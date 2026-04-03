extends CanvasLayer

@onready var coin_text: Label = $CoinText

func update_coin_display(total_coins: int):
	coin_text.text = "Coins: " + str(total_coins)
