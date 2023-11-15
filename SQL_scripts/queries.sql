-- Identify Tax Deductions by State

SELECT state, SUM(tax_deduction) AS total_tax_deduction
FROM PAYE
GROUP BY state;

-- Filter Unremitted Tax Deductions

SELECT *
FROM PAYE
WHERE remitted_flag = 'N';

-- Calculate Total Unremitted Tax Deductions

SELECT SUM(tax_deduction) AS total_unremmitted_tax_deduction
FROM PAYE
WHERE remitted_flag = 'N';

-- Analyze Unremitted Tax Deductions by Employer

SELECT employer, SUM(tax_deduction) AS total_unremmitted_tax_deduction
FROM PAYE
WHERE remitted_flag = 'N'
GROUP BY employer;

-- Identify Top Unremitted Tax Deductions

SELECT *
FROM PAYE
WHERE remitted_flag = 'N'
ORDER BY tax_deduction DESC;

-- Analyze Unremitted Tax Deductions by Industry

SELECT industry, SUM(tax_deduction) AS total_unremmitted_tax_deduction
FROM PAYE
WHERE remitted_flag = 'N'
GROUP BY industry;

-- Analyze Unremitted Tax Deductions by Tax Period

SELECT tax_period, SUM(tax_deduction) AS total_unremmitted_tax_deduction
FROM PAYE
WHERE remitted_flag = 'N'
GROUP BY tax_period;

-- Identify Repeat Unremitted Tax Deduction Offenders

SELECT employer, COUNT(*) AS count_of_unremmitted_tax_deductions
FROM PAYE
WHERE remitted_flag = 'N'
GROUP BY employer
HAVING COUNT(*) >= 3;

-- Analyze Trends in Unremitted Tax Deductions

SELECT tax_period, SUM(tax_deduction) AS total_tax_deduction,
       SUM(CASE WHEN remitted_flag = 'Y' THEN tax_deduction ELSE 0 END) AS total_remitted_tax_deduction
FROM PAYE
GROUP BY tax_period;

-- Calculate Potential Revenue Generated from Unremitted Tax Deductions

SELECT SUM(tax_deduction) AS total_unremmitted_tax_deduction
FROM PAYE
WHERE remitted_flag = 'N'
* 0.15 AS potential_revenue;
