log using "2nd Version.log", text replace

// Data Processing and Outlier Handling
duplicates report // checking duplicates

sort PERMCO PERMNO // validating one-to-one mapping between PERMCO and PERMNO
bysort PERMCO: gen tag = cond(PERMNO == PERMNO[_n-1], 0, 1)
bysort PERMCO: egen unique_permno_count = total(tag)
tabulate unique_permno_count
keep if unique_permno_count == 1

*misstable summarize
*summarize RET , detail
*summarize vwretd, detail
*graph box RET 
*graph box vwretd
*hist RET,normal
*hist vwretd, normal

// Create year-month variable for grouping
gen month_of_date = mofd(date) // Convert daily date to year-month format
format month_of_date %tm 

// 2% winsorization to deal with outliers
winsor2 RET, cut(2 98) replace
winsor2 vwretd, cut(2 98) replace

// Checking the missing values
count if missing(RET)
count if missing(vwretd)

// Interpolation to deal with missing values
*⁠ispolation
xtset PERMCO date
csipolate RET date, generate(ret_csi)

// Selecting only months with at least 20 valid trading days to improve accuracy
sort PERMCO PERMNO month_of_date
egen count_nonmissing_RET = count(RET), by(PERMCO PERMNO month_of_date)
gen dummy_RET_20 = count_nonmissing_RET >= 20
keep if dummy_RET_20 == 1

// Generate signed returns
gen r_plus = cond(RET > 0, RET, 0)
gen r_minus = cond(RET < 0, RET, 0)
gen f_plus = cond(vwretd > 0, vwretd, 0)
gen f_minus = cond(vwretd < 0, vwretd, 0)

// Calculate covariances in line with the article formula
gen cov_n = r_minus * f_minus
gen cov_p = r_plus * f_plus
gen cov_mplus = r_minus * f_plus
gen cov_mminus = r_plus * f_minus

// Calculate squared market returns
gen f_squared = vwretd^2

// Aggregate values by PERMNO and year_month, summing covariances
bysort PERMNO month_of_date: egen cov_n_sum = total(cov_n)
bysort PERMNO month_of_date: egen cov_p_sum = total(cov_p)
bysort PERMNO month_of_date: egen cov_mplus_sum = total(cov_mplus)
bysort PERMNO month_of_date: egen cov_mminus_sum = total(cov_mminus)
bysort PERMNO month_of_date: egen f_squared_sum = total(f_squared)

// Aggregate the return to convert daily data to monthly format
bysort PERMNO month_of_date: egen monthly_ret = total(RET)

// Calculate the traditional and semibetas in line with the article formula
gen beta_n = cov_n_sum / f_squared_sum
gen beta_p = cov_p_sum / f_squared_sum
gen beta_mplus = -cov_mplus_sum / f_squared_sum
gen beta_mminus = -cov_mminus_sum / f_squared_sum
gen beta_trad = beta_n+ beta_p- beta_mplus- beta_mminus

// Drop temporary variables
*drop cov_n_sum cov_p_sum cov_mplus_sum cov_mminus_sum f_squared_sum

// Keep only the last row for each group to avoid duplication
sort PERMCO month_of_date
bysort PERMCO month_of_date (date): keep if _n == _N

// Generate future return as the lag of RET
xtset PERMCO month_of_date
gen future_monthly_return= F.monthly_ret

// Result Analysis for Table 1 (summary statistics) comparison
pwcorr beta_n beta_p beta_mplus beta_mminus, sig star(0.05)
pwcorr beta_trad beta_n beta_p beta_mplus beta_mminus, sig star(0.05)
tabstat beta_trad beta_n beta_p beta_mplus beta_mminus, stats(mean median sd)

// Fama-Macbeth Regression for traditional and semibeta 
xtfmb future_monthly_return beta_trad
xtfmb future_monthly_return beta_n beta_p beta_mplus beta_mminus

// Creating matrix for semibetas coefficients
matrix list e(b)
matrix coeffs = e(b)

// Extract semibetas coefficients and multiplying with 12 to annualize
scalar annualized_risk_premium_n = coeffs[1,1] * 12
scalar annualized_risk_premium_p = coeffs[1,2] * 12
scalar annualized_risk_premium_mplus = coeffs[1,3] * 12
scalar annualized_risk_premium_mminus = coeffs[1,4] * 12

// Display results similar with the article format
di "Annualized Risk Premiums:"
di "Beta_n: " annualized_risk_premium_n
di "Beta_p: " annualized_risk_premium_p
di "Beta_mplus: " annualized_risk_premium_mplus
di "Beta_mminus: " annualized_risk_premium_mminus

log close
