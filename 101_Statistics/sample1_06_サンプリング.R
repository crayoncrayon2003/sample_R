
main <- function() {
  cat(" ######## 母集団データを作る ######## ", "\n")
  set.seed(123)

  N <- 1000
  population <- data.frame(
    id     = 1:N,
    sex    = sample(c("M", "F"), N, replace = TRUE),
    region = sample(paste0("R", 1:10), N, replace = TRUE),
    value  = rnorm(N, mean = 50, sd = 10)
  )
  cat(head(population$value, 15), "\n")


  cat(" ######## 単純無作為抽出 ######## ", "\n")
  n <- 100
  sample_srs <- population[sample(N, n), ]
  cat(sample_srs$value, "\n")
  cat(mean(sample_srs$value), "\n")


  cat(" ######## 層化抽出 ######## ", "\n")
  n_each <- 50
  sample_stratified <- do.call(
    rbind,
    lapply(split(population, population$sex), function(df) {
      df[sample(nrow(df), n_each), ]
    })
  )
  cat(sample_stratified$value, "\n")
  cat(mean(sample_stratified$value), "\n")

  cat(" ######## 多段抽出 ######## ", "\n")
  # 第1段階：地域を抽出
  regions_selected <- sample(unique(population$region), 3)

  # 第2段階：地域内から抽出
  sample_multistage <- do.call(
    rbind,
    lapply(regions_selected, function(r) {
      df <- subset(population, region == r)
      df[sample(nrow(df), 20), ]
    })
  )
  cat(sample_stratified$value, "\n")
  cat(mean(sample_multistage$value), "\n")


  cat(" ######## 集落抽出 ######## ", "\n")
  clusters_selected <- sample(unique(population$region), 3)

  sample_cluster <- subset(
    population,
    region %in% clusters_selected
  )
  cat(sample_cluster$value, "\n")
  cat(mean(sample_cluster$value), "\n")

  cat(" ######## 系統抽出 ######## ", "\n")
  n <- 100
  k <- floor(N / n)

  start <- sample(1:k, 1)
  indices <- seq(start, by = k, length.out = n)

  sample_systematic <- population[indices, ]
  cat(sample_systematic$value, "\n")
  cat(mean(sample_systematic$value), "\n")


}


main()
