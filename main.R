library(tercen)
library(dplyr)
library(tidyr)

ctx = tercenCtx()

dividend_col_id <- ctx$op.value(name = "Dividend Column ID", as.double, 0)
divisor_col_id <- ctx$op.value(name = "Divisor Column ID", as.double, 0)
mode <- ctx$op.value(name = "Method", as.character, "y / x")

if(dividend_col_id > 0 & divisor_col_id > 0) {
  
  ctx %>% 
    select(.ri, .ci, .y) %>%
    tidyr::complete(.ri, .ci) %>%
    arrange(.ri, .ci) %>%
    group_by(.ri) %>%
    summarise(ratio = if_else(
      mode == "y / x",
      .y[.ci == dividend_col_id - 1L] / .y[.ci == divisor_col_id- 1L],
      .y[.ci == dividend_col_id - 1L] / (.y[.ci == dividend_col_id - 1L] + .y[.ci == divisor_col_id- 1L]),
    )) %>%
    tidyr::drop_na() %>%
    ctx$addNamespace() %>%
    ctx$save()
    
} else {
  
  ctx %>% 
    select(.ri, .ci, .x, .y) %>% 
    group_by(.ri, .ci) %>%
    transmute(ratio = if_else(
      mode == "y / x",
      .y / .x,
      .y / (.x + .y)
    )) %>%
    ctx$addNamespace() %>%
    ctx$save()
  
}

