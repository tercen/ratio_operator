library(tercen)
library(dplyr)

ctx = tercenCtx()

dividend_col_id <- ctx$op.value(name = "Dividend Column ID", as.double, 0)
divisor_col_id <- ctx$op.value(name = "Divisor Column ID", as.double, 0)

if(dividend_col_id > 0 & divisor_col_id > 0) {
  
  ctx %>% 
    select(.ri, .ci, .y) %>%
    group_by(.ri) %>%
    summarise(ratio = .y[.ci == dividend_col_id - 1L] / .y[.ci == divisor_col_id- 1L])
    ctx$addNamespace() %>%
    ctx$save()
    
} else {
  
  ctx %>% 
    select(.ri, .ci, .x, .y) %>% 
    group_by(.ri, .ci) %>%
    transmute(ratio = .y / .x) %>%
    ctx$addNamespace() %>%
    ctx$save()
  
}

