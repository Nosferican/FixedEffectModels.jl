using RDatasets, DataFrames, FixedEffectModels, Base.Test

df = dataset("plm", "Cigar")
df[:pState] = pool(df[:State])
df[:pYear] = pool(df[:Year])

# partial_out
partial_out(Sales + Price ~ NDI, df)
partial_out(Sales + Price ~ NDI |> pState, df)
partial_out(Sales + Price ~ 1 |> pState, df)
partial_out(Sales + Price ~ 1, df)