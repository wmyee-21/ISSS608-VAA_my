# prepare_data.R

library(tidyverse)

# 1. Read raw data
raw <- read_delim(
  "data/Motor_insurance.csv",
  delim = ";",
  show_col_types = FALSE
)

cat("Raw dimensions:", nrow(raw), "rows x", ncol(raw), "columns\n")

# 2. Drop rows with missing values
ins <- raw |>
  drop_na(fuel_type, vehicle_value, vehicle_age, age_driving_licence)

cat("After dropping NAs:", nrow(ins), "rows retained (",
    round(nrow(ins) / nrow(raw) * 100, 1), "% of original)\n")

# 3. Recode categorical variables into labelled factors
# policy_type: ordered from minimal cover to fully comprehensive
policy_type_levels  <- c("TP", "TPG", "CC", "COMP_E", "COMP_N")
policy_type_labels  <- c(
  "TP",      # stored as short code — the stacked bar chart uses these
  "TPG",
  "CC",
  "COMP_E",
  "COMP_N"
)

ins <- ins |>
  mutate(
    # --- Policy descriptors ---
    policy_type = factor(
      policy_type,
      levels = c("TP", "TPG", "CC", "COMP_E", "COMP_N"),
      labels = c("TP", "TPG", "CC", "COMP_E", "COMP_N")
      # Short codes retained in the CSV so both the stacked bar chart
      # (which needs them) and the severity decomposition chart work without
      # further recoding.  The Quarto file applies readable labels via
      # scale overrides where needed.
    ),
    policy_status = factor(
      policy_status,
      levels = c("A", "C"),
      labels = c("Active", "Cancelled")
    ),
    business_type = factor(
      business_type,
      levels = c("NB", "P"),
      labels = c("New business", "Portfolio renewal")
    ),
    payment_frequency = factor(
      payment_frequency,
      levels = c("A", "S", "Q"),
      labels = c("Annual", "Semiannual", "Quarterly")
    ),
    # bonus_score: ordered from best to worst driving history
    bonus_score = factor(
      bonus_score,
      levels = c("G", "N", "B"),
      labels = c("Good history", "Neutral", "Bad history")
    ),
    fuel_type = factor(
      fuel_type,
      levels = c("D", "G"),
      labels = c("Diesel", "Gasoline")
    ),
    municipality_type = factor(
      municipality_type,
      levels = c("I", "C", "IS"),
      labels = c("Inland", "Coastal", "Islands")
    ),
    circulation_area = factor(
      circulation_area,
      levels = c("U", "R"),
      labels = c("Urban", "Rural")
    ),
    # year stored as ordered factor so charts read 2022 -> 2023 -> 2024
    year = factor(year, levels = c(2022, 2023, 2024), ordered = TRUE)
  )

# 4. Derived variables
ins <- ins |>
  mutate(
    # 4a. Licence tenure (years held)
    #     age_driving_licence is the AGE AT WHICH the driver obtained their
    #     licence (mean ~23, range 0-80) — NOT a calendar year.
    #     Tenure = driver_age - age_driving_licence gives years of experience.
    #     pmax(..., 0) floors at zero — a small number of records produce a
    #     negative value due to data entry errors; treating those as 0 is
    #     the most conservative interpretation.
    licence_tenure = pmax(driver_age - age_driving_licence, 0),

    # 4b. Driver age band (10-year bins, 18-25 isolated as high-risk cohort)
    #     ordered = TRUE preserves the left-to-right reading order in charts.
    age_band = cut(
      driver_age,
      breaks = c(17, 25, 35, 45, 55, 65, 75, 99),
      labels = c("18 to 25", "26 to 35", "36 to 45",
                 "46 to 55", "56 to 65", "66 to 75", "76+"),
      ordered_result = TRUE
    ),

    # 4c. Vehicle value quintile
    #     Raw vehicle values span ~200 EUR to ~374,000 EUR (strong right skew).
    #     Quintiles give each value band equal weight; ntile assigns ranks
    #     1 (cheapest 20%) through 5 (most expensive 20%).
    value_quintile = factor(
      ntile(vehicle_value, 5),
      levels = 1:5,
      labels = c("Q1 Lowest", "Q2", "Q3", "Q4", "Q5 Highest")
    )
  )

cat("Derived columns added: licence_tenure, age_band, value_quintile\n")

# 5. Validation checks before writing
stopifnot(
  "licence_tenure contains negatives after flooring" =
    min(ins$licence_tenure) >= 0,
  "age_band has unexpected NAs" =
    sum(is.na(ins$age_band)) == 0,
  "value_quintile has unexpected NAs" =
    sum(is.na(ins$value_quintile)) == 0,
  "Expected five policy_type levels" =
    nlevels(ins$policy_type) == 5
)

cat("All validation checks passed.\n")

# 6. Write clean CSV
write_csv(ins, "data/motor_clean.csv")

cat("Written: data/motor_clean.csv\n")
cat("Final dimensions:", nrow(ins), "rows x", ncol(ins), "columns\n")
