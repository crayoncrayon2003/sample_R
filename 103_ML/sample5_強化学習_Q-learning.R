# =========================================================
# シーン
#   ECサイトの運営者として、
#   「クーポンを配る／配らない」という行動を選び、
#   長期的に購入を最大化したい。
#
# 状態 state
#   0 = 低関与ユーザー
#   1 = 高関与ユーザー
#
# 行動 action
#   0 = クーポンを配らない
#   1 = クーポンを配る
#
# 報酬 reward
#   購入したら 1、しなければ 0
# =========================================================




# ===============================
# ディレクトリの取得
# ===============================
get_script_dir <- function() {
  if (!is.null(sys.frames()[[1]]$ofile)) {
    return(dirname(normalizePath(sys.frames()[[1]]$ofile)))
  }
  args <- commandArgs(trailingOnly = FALSE)
  file_arg <- grep("--file=", args, value = TRUE)
  if (length(file_arg) > 0) {
    return(dirname(normalizePath(sub("--file=", "", file_arg))))
  }
  normalizePath(".")
}


# ===============================
# 保存関数
# ===============================
save_data <- function(df, base_dir) {
  if (!dir.exists(base_dir)) {
    dir.create(base_dir, recursive = TRUE)
  }
  write.csv(df, file.path(base_dir, "data.csv"), row.names = FALSE)
}


# ===============================
# 読込関数
# ===============================
load_data <- function(base_dir) {
  file_path <- file.path(base_dir, "data.csv")
  if (file.exists(file_path)) {
    return(read.csv(file_path))
  } else {
    warning("file not found -> data.csv")
    return(data.frame())
  }
}


# ===============================
# 削除関数
# ===============================
delete_data <- function(base_dir) {
  file_path <- file.path(base_dir, "data.csv")
  if (file.exists(file_path)) {
    file.remove(file_path)
    message("removed file -> data.csv")
  }
}


# ===============================
# 環境定義
# ===============================
step_env <- function(state, action) {

  # 購入確率（真の環境）
  base_p <- ifelse(state == 1, 0.4, 0.1)
  coupon_effect <- ifelse(action == 1, 0.3, 0.0)

  p_buy <- min(base_p + coupon_effect, 0.95)

  reward <- rbinom(1, 1, p_buy)

  # 次の状態（購入したら高関与になりやすい）
  next_state <- ifelse(
    runif(1) < (0.7 * reward + 0.2),
    1, 0
  )

  list(
    next_state = next_state,
    reward = reward
  )
}


# ===============================
# Q学習
# ===============================
train_q_learning <- function(
  episodes = 5000,
  alpha = 0.1,   # 学習率
  gamma = 0.9,   # 割引率
  epsilon = 0.1  # 探索率
) {

  n_state <- 2
  n_action <- 2

  Q <- matrix(0, nrow = n_state, ncol = n_action)

  for (ep in 1:episodes) {

    state <- sample(0:1, 1)

    for (t in 1:10) {

      # ε-greedy
      if (runif(1) < epsilon) {
        action <- sample(0:1, 1)
      } else {
        action <- which.max(Q[state + 1, ]) - 1
      }

      result <- step_env(state, action)

      next_state <- result$next_state
      reward <- result$reward

      # Q更新
      Q[state + 1, action + 1] <-
        Q[state + 1, action + 1] +
        alpha * (
          reward +
            gamma * max(Q[next_state + 1, ]) -
            Q[state + 1, action + 1]
        )

      state <- next_state
    }
  }

  Q
}


# ===============================
# 学習実行
# ===============================
Q_table <- train_q_learning()

colnames(Q_table) <- c("NoCoupon", "Coupon")
rownames(Q_table) <- c("LowEngagement", "HighEngagement")

print("学習後のQテーブル:")
print(round(Q_table, 3))


# ===============================
# 最適方策
# ===============================
policy <- apply(Q_table, 1, which.max) - 1
names(policy) <- rownames(Q_table)

print("最適行動（0=配らない, 1=配る）:")
print(policy)
