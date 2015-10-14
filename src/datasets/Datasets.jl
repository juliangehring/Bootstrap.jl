module Datasets

using DataFrames

## 'city' dataset from the 'boot' package
const city = DataFrame(U = [138,  93, 61, 179, 48, 37, 29, 23,  30,  2],
                       X = [143, 104, 69, 260, 75, 63, 50, 48, 111, 50])

## 'bigcity' dataset from the 'boot' package
const bigcity = DataFrame(U = [138, 93, 61, 179, 48, 37, 29, 23, 30, 2, 38, 46, 71, 25, 298, 74, 50, 76, 381, 387, 78, 60, 507, 50, 77, 64, 40, 136, 243, 256, 94, 36, 45, 67, 120, 172, 66, 46, 121, 44, 64, 56, 40, 116, 87, 43, 43, 161, 36],
                          X = [143, 104, 69, 260, 75, 63, 50, 48, 111, 50, 52, 53, 79, 57, 317, 93, 58, 80, 464, 459, 106, 57, 634, 64, 89, 77, 60, 139, 291, 288, 85, 46, 53, 67, 115, 183, 86, 65, 113, 58, 63, 142, 64, 130, 105, 61, 50, 232, 54])

## 'survival' dataset from the 'boot' package
const survival = DataFrame(Dose = [117.5, 117.5, 235.0, 235.0, 470.0, 470.0, 470.0, 705.0, 705.0, 940.0, 940.0, 940.0, 1410.0, 1410.0],
                           Surv = [44.0, 55.0, 16.0, 13.0, 4.0, 1.96, 6.12, 0.5, 0.32, 0.11, 0.015, 0.019, 0.7, 0.006])

## 'aircondit' dataset from the 'boot' package
const aircondit = Float64[3, 5, 7, 18, 43, 85, 91, 98, 100, 130, 230, 487]

export
    city,
    bigcity,
    survival,
    aircondit

end
