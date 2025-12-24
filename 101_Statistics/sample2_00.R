# ==========================================
# 設定変数 (共通データ)
# ==========================================
settings <- data.frame(
  level    = 1:6,
  big_prob = 1/c(273.1, 270.8, 260.1, 250.1, 243.6, 226.0),
  reg_prob = 1/c(381.0, 350.5, 316.6, 281.3, 270.8, 252.1),
  pay_out  = c(0.970, 0.979, 0.999, 1.021, 1.040, 1.075)
)

# ==========================================
# 関数定義（固定消費枚数 -1.47 ベースのグラフ）
# ==========================================
plot_slump_graph <- function(n_games = 8000) {
  colors <- c("blue", "cyan", "green", "yellow", "orange", "red")
  plot(NULL, xlim=c(0, n_games), ylim=c(-3000, 3000),  xlab="ゲーム数", ylab="差枚数", main="設定別スランプグラフ・シミュレーション")
  abline(h = 0, col = "black", lty = 2)

  for(i in 1:6) {
    # 各ゲームで BIG(1), REG(2), ハズレ(0) を抽選
    # 確率は 1/x
    p_big <- settings$big_prob[i]
    p_reg <- settings$reg_prob[i]
    p_lose <- 1 - (p_big + p_reg)

    # 全ゲームの結果を一度に生成
    outcomes <- sample(
      # bit, reg, lose
      c(240, 96, -1.47),
      size = n_games, replace = TRUE, prob = c(p_big, p_reg, p_lose)
    )

    slump_line <- cumsum(outcomes)
    lines(1:n_games, slump_line, col = colors[i], lwd = 2)
  }
  legend("topleft", legend = paste("設定", 1:6), col = colors, lty = 1, lwd = 2, cex=0.8)
}


# ==========================================
# 関数定義（機械割ベースのグラフ）
# ==========================================
plot_slump_graph_by_payout <- function(n_games = 8000) {
  colors <- c("blue", "cyan", "green", "yellow", "orange", "red")
  plot(NULL, xlim=c(0, n_games), ylim=c(-3000, 3000), xlab="ゲーム数", ylab="差枚数", main="設定別スランプグラフ（機械割準拠）")
  abline(h = 0, col = "black", lty = 2)

  for(i in 1:6) {
    # 1. ボーナスによる獲得枚数の期待値を計算
    # 240枚(BIG) * 確率 + 96枚(REG) * 確率
    bonus_expected = (240 * settings$big_prob[i]) + (96 * settings$reg_prob[i])

    # 2. 機械割から導かれる「1Gあたりのトータル期待値」
    total_expected_per_g = 3 * (settings$pay_out[i] - 1)

    # 3. 通常時（ベース）の削り枚数を逆算
    # 通常時の削り = トータル期待値 - ボーナス期待値
    base_loss_per_g = total_expected_per_g - bonus_expected

    # シミュレーション：毎ゲーム「通常ベース」で減り、ボーナスを引いたら増える
    # 簡易化のため、通常時は毎ゲーム一定で減ると仮定（よりリアルにするなら小役も抽選が必要）
    results <- rep(base_loss_per_g, n_games)

    # ボーナスのフラグ抽選（二項分布の試行）
    big_flags <- rbinom(n_games, 1, settings$big_prob[i])
    reg_flags <- rbinom(n_games, 1, settings$reg_prob[i])

    slump_line <- cumsum(results + (big_flags * 240) + (reg_flags * 96))
    lines(1:n_games, slump_line, col = colors[i], lwd = 2)
  }
  legend("topleft", legend = paste0("設定", 1:6, " (", settings$pay_out*100, "%)"), col = colors, lty = 1, lwd = 2, cex=0.8)
}



main <- function() {
  set.seed(123)

  par(mfrow=c(1,2))
  n=3000
  plot_slump_graph_by_payout(n)
  plot_slump_graph(n)

}

main()
