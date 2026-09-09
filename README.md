# Empirical Capital Market Analysis with Python, R and Stata

This repository contains a set of empirical capital-market analyses developed as part of the course **Introduction to Capital Market Databases and Statistical Analysis Software**.

The project applies **Python, R, and Stata** to large-scale financial datasets and covers data preparation, econometric modelling, asset-pricing tests, portfolio construction, robustness analysis, and simulation. The individual analyses are designed to demonstrate how different statistical tools can be used to investigate capital-market questions from complementary perspectives.

## Project Overview

| Component | Main Focus | Methods / Tools |
|---|---|---|
| **Stata** | Beta and semibeta asset-pricing analysis | Panel-data processing, semibeta construction, Fama–MacBeth regression |
| **R** | Asset-pricing anomalies and portfolio analysis | WRDS, CRSP/Compustat, portfolio sorting, FF3/FF5 regressions, bootstrap validation |
| **Python** | Euro trading-volume analysis | Large-scale data processing, feature engineering, OLS regression, VIF |
| **Python** | Retirement uncertainty simulation | Monte Carlo simulation, investment-return uncertainty, retirement-risk analysis |

---

## 1. Stata — Beta and Semibeta Asset-Pricing Analysis

The Stata analysis examines whether decomposing traditional market beta into different **semibeta components** provides additional information about the cross-section of future stock returns.

### Workflow

- Processed a large panel of daily stock and market returns.
- Checked duplicate observations and firm-identifier consistency.
- Applied outlier treatment and prepared daily return data for monthly analysis.
- Decomposed stock and market returns into positive and negative components.
- Constructed four semibeta measures based on combinations of positive and negative stock and market returns.
- Reconstructed traditional beta from the semibeta components.
- Aggregated daily observations to the monthly level.
- Examined correlations and summary statistics across traditional beta and semibetas.
- Estimated cross-sectional return relationships using **Fama–MacBeth regressions**.
- Converted monthly coefficient estimates into annualized risk-premium measures.

### Methods

`Stata` • `Panel Data` • `Asset Pricing` • `Beta / Semibeta` • `Fama–MacBeth Regression` • `Outlier Treatment`

The accompanying **Stata Project Report** provides the detailed methodology, empirical motivation, and interpretation of the analysis.

---

## 2. R — Asset-Pricing Anomalies and Portfolio Analysis

The R project builds an end-to-end empirical asset-pricing pipeline using historical U.S. equity and accounting data.

### Data Pipeline

Data are retrieved from **WRDS** and combine:

- **CRSP** stock-market data
- **Compustat** accounting data
- CRSP–Compustat linking information
- Fama–French factor data

The workflow handles identifier mapping, valid company-date ranges, firm-year matching, duplicate observations, and accounting-data filters before constructing the empirical variables.

### Asset-Pricing Signals

Three characteristics are analyzed:

- **Book-to-Market (BM)**
- **Earnings-to-Price (EP)**
- **12-Month Momentum (Mom12m)**

Stocks are sorted using alternative breakpoint specifications, including NYSE-based breakpoints and broader portfolio-ranking approaches.

### Portfolio Construction

For each characteristic, the analysis constructs **long-short portfolios** and compares:

- Equal-weighted (EW) returns
- Value-weighted (VW) returns
- Alternative portfolio-sorting methods

The analysis also applies robustness checks such as excluding financial firms, excluding low-price stocks, and winsorizing extreme observations.

### Factor Models and Validation

Portfolio returns are evaluated using:

- **Fama–French 3-Factor Model**
- **Fama–French 5-Factor Model**
- **Bootstrap resampling** for coefficient confidence intervals
- Cumulative-return analysis
- Return-distribution statistics
- Sharpe ratios

The analysis finds that momentum is the most consistent of the three examined anomalies in the implemented specifications, while equal-weighted portfolios show stronger risk-adjusted performance than value-weighted portfolios.

### Methods

`R` • `WRDS` • `CRSP` • `Compustat` • `Portfolio Sorting` • `Long-Short Portfolios` • `Fama–French 3/5 Factor Models` • `Bootstrap` • `Robustness Analysis`

---

## 3. Python — Euro Trading Volume Regression Analysis

This analysis investigates the determinants of **Euro trading volume** using a large transaction-level dataset.

After data cleaning and filtering, the OLS analysis contains approximately **23.8 million observations**.

### Data Preparation and Feature Engineering

The Python workflow:

- Merges transaction and instrument datasets using ISIN.
- Cleans missing, zero, and invalid price/volume observations.
- Constructs Euro trading volume with instrument-specific calculations.
- Applies IQR-based outlier filtering.
- Creates explanatory variables capturing:
  - trading inside vs. outside market hours,
  - weekday effects,
  - buy vs. sell direction,
  - instrument type.

### Regression and Multicollinearity Analysis

Two OLS specifications are used.

The first model deliberately includes the full set of dummy variables to demonstrate the resulting **multicollinearity / dummy-variable trap**. Variance Inflation Factors (VIFs) are calculated to diagnose the issue.

A second specification removes redundant reference categories and re-estimates the regression. The revised model substantially reduces the VIFs and allows the effects of trading time, weekdays, trade direction, and instrument type to be interpreted more reliably.

### Methods

`Python` • `Pandas` • `NumPy` • `Statsmodels` • `Large-Scale Data Processing` • `Feature Engineering` • `OLS Regression` • `VIF` • `Multicollinearity`

---

## 4. Python — Retirement Simulation under Investment Uncertainty

A separate Python simulation explores how investment uncertainty affects the number of years an individual may need to work before retirement.

The simulation incorporates:

- Starting wealth
- Savings rate
- Investment-return assumptions
- Return volatility
- Inflation
- Retirement withdrawals
- Mortality probabilities
- Risk of exhausting retirement wealth

Repeated simulations generate a distribution of required working years, which is then used to examine how the retirement horizon changes across different uncertainty levels.

### Methods

`Python` • `Monte Carlo Simulation` • `Risk Analysis` • `Retirement Planning` • `Investment Returns` • `Data Visualization`

---

## Repository Structure

```text
.
├── Stata_Project_Report.pdf
├── [Stata analysis / code]
├── [R project / analysis]
├── [Python project / notebook]
└── README.md
```

*File names can be adjusted in this section to match the final repository structure.*

## Key Skills Demonstrated

- Empirical asset-pricing analysis
- Large-scale financial-data processing
- CRSP and Compustat data integration
- Econometric modelling
- Fama–MacBeth regression
- Fama–French factor models
- Portfolio construction and backtesting
- Statistical robustness and bootstrap validation
- Multicollinearity diagnostics
- Monte Carlo simulation
- Python, R and Stata

## Notes on Data

Some datasets used in this project are accessed through licensed academic databases such as **WRDS / CRSP / Compustat** or course-provided datasets and therefore are not redistributed in this repository.

Credentials and local file paths are intentionally excluded from the public repository. Users with appropriate data access can adapt the scripts to their own environment.

## Authors

**Kexin Zhao**  
with **Muhammad Gohan Pahlevi** and **Osman Huzur Solmaz**

Course project: *Introduction to Capital Market Databases and Statistical Analysis Software*
