library(dplyr)
library(lubridate)
library(readr)
time.data <- read_csv('timestamp_test.csv')

time.data %>%
    transmute(
        submit_datetime = dmy_hm(Timestamp)
        ,submit_date = date(submit_datetime)
        ,submit_hour = hour(submit_datetime) %/% 6
        ,service = Service
        ,hits = Count
    ) %>%
    group_by(
        service
        ,submit_date
        ,submit_hour
    ) %>%
    summarise(
        hour_hits = sum(hits)
    ) %>%
    arrange(
        service
        ,submit_date
        ,submit_hour
    ) %>%
    filter(
        row_number() == n()
    ) -> events.data
