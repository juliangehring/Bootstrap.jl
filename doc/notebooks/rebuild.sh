#!/usr/bin/env sh

jupyter nbconvert --to notebook --execute --ExecutePreprocessor.timeout=60 --inplace city.ipynb
