The function `demean` accepts a dataframe, columns (an array of synbols), and a set of grouping variables (an array of an array of symbols). It returns new columns, with the suffix `p`, corresponding to demeaned column.


```julia
using DataFrames
using RDatasets

df = dataset("plm", "Cigar")
result = FixedEffects.demean(df, :Sales, Vector{Symbol}[[:State],[:Year]])
```

The new Sales_p column averagse to zero with respect to both state and year

```julia
by(result, :State, df -> mean(df[:Sales]))
by(result, :Year, df -> mean(df[:Sales]))
```

If the dataframe contains missing values, new rows are set to missing

```julia
df[1:5, :Sales] = NA
result = FixedEffects.demean(df, [:Sales], Vector{Symbol}[[:State],[:Year]])
```




N = 1000000
K = 10000
df = DataFrame(
  v1 =  rand(1:N, N),
  v2 =  rand(1:K, N),
  v3 =  randn(N), # numeric e.g. 23.5749
  v4 =  randn(N) # numeric e.g. 23.5749
)
@time FixedEffects.demean(df, [:v3,:v4], Vector{Symbol}[[:v1]])
#elapsed time: 2.783390545 seconds (1131099264 bytes allocated, 24.41% gc time)
1000000x6 DataFrame
@time FixedEffects.demean(df, [:v3,:v4], Vector{Symbol}[[:v1],[:v2]])
# elapsed time: 17.700998963 seconds (7270095584 bytes allocated, 29.14% gc time)
1000000x6 DataFrame



N = 1000000
K = N/100
df = data_frame(
  v1 =  sample(N, N, replace = TRUE),
  v2 =  sample(K, N, replace = TRUE),
  v3 =  runif(N), # numeric e.g. 23.5749
  v4 =  runif(N) # numeric e.g. 23.5749
)
system.time(felm(v3+v4~1|v1, df))
 user  system elapsed 
3.909   0.117   4.009 
system.time(felm(v3+v4~1|v1+v2, df))
 user  system elapsed 
5.009   0.147   4.583 