# prepare_data.R
# Cleans the raw Spanish motor insurance dataset and writes motor_clean.csv

library(tidyverse)

# 1. Read raw data
raw <- read_delim(
  "data/Motor_insurance.csv",
  delim = ";",
  show_col_types = FALSE
)

cat("Raw dimensions:", nrow(raw), "rows x", ncol(raw), "columns\n")

# 2. Drop rows with NAs in key variables
ins <- raw |>
  drop_na(fuel_type, vehicle_value, vehicle_age, age_driving_licence)

cat("After dropping NAs:", nrow(ins), "rows retained (",
    round(nrow(ins) / nrow(raw) * 100, 1), "% of original)\n")

# 3. Recode categorical variables to readable factor labels
ins <- ins |>
  mutate(
    policy_type = factor(
      policy_type,
      levels = c("TP", "TPG", "CC", "COMP_E", "COMP_N")
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
    year = factor(year, levels = c(2022, 2023, 2024), ordered = TRUE)
  )

# 4. Derived variables
ins <- ins |>
  mutate(
    # Years of driving experience (floored at 0 to handle data entry errors)
    licence_tenure = pmax(driver_age - age_driving_licence, 0),

    # 10-year age bins; 18-25 isolated as high risk, 76+ isolated as senior
    age_band = cut(
      driver_age,
      breaks = c(17, 25, 35, 45, 55, 65, 75, 99),
      labels = c("18-25", "26-35", "36-45",
                 "46-55", "56-65", "66-75", "76+"),
      ordered_result = TRUE
    ),

    # Vehicle value quintiles, equal-weight bands
    value_quintile = factor(
      ntile(vehicle_value, 5),
      levels = 1:5,
      labels = c("Q1 Lowest", "Q2", "Q3", "Q4", "Q5 Highest")
    )
  )

cat("Derived columns added: licence_tenure, age_band, value_quintile\n")

# 5. Round numeric columns to reduce file size
# Premium and incurred to cents. Exposure to 6 dp. Vehicle age to integer.
# Keeps all reported figures intact while shrinking the CSV from ~120MB to ~80MB.
money_cols <- c(
  "total_premium", "liability_premium", "property_damage_premium",
  "theft_premium", "fire_premium", "glass_premium",
  "legal_protection_premium", "occupants_premium",
  "total_incurred", "liability_incurred", "liability_property_incurred",
  "liability_injury_incurred", "property_incurred", "theft_incurred",
  "fire_incurred", "glass_incurred", "legal_protection_incurred",
  "occupants_incurred", "vehicle_value"
)
exposure_cols <- c("total_exposure", "liability_exposure")
int_cols      <- c("vehicle_age", "age_driving_licence")

ins <- ins |>
  mutate(
    across(all_of(money_cols),    \(x) round(x, 2)),
    across(all_of(exposure_cols), \(x) round(x, 6)),
    across(all_of(int_cols),      as.integer),
    power_to_weight_ratio = round(power_to_weight_ratio, 2)
  )

# 6. Validation checks
stopifnot(
  "licence_tenure contains negatives" =
    min(ins$licence_tenure) >= 0,
  "age_band has unexpected NAs" =
    sum(is.na(ins$age_band)) == 0,
  "value_quintile has unexpected NAs" =
    sum(is.na(ins$value_quintile)) == 0,
  "Expected five policy_type levels" =
    nlevels(ins$policy_type) == 5
)

cat("All validation checks passed.\n")

# 7. Write clean CSV
write_csv(ins, "data/motor_clean.csv.gz")

cat("Written: data/motor_clean.csv.gz\n")
cat("Final dimensions:", nrow(ins), "rows x", ncol(ins), "columns\n")
