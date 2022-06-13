extends CanvasLayer

func update_score(new_score):
	$Score.text = str(new_score)


func init_game_over_menu(score, highscore):
	

	
	$Score.hide()
	$GameOver/TextureRect/ScoreLabel.text = str(score)
	$GameOver/TextureRect/HighScoreLabel.text = str(highscore)

	if score < 25:
		$GameOver/TextureRect/Medal.frame = 0

	elif score >= 25:
		$GameOver/TextureRect/Medal.frame = 1

	elif score >= 50:
		$GameOver/TextureRect/Medal.frame = 2

	elif score >= 75:
		$GameOver/TextureRect/Medal.frame = 3

	elif score >= 100:
		$GameOver/TextureRect/Medal.frame = 4


	$GameOver.show()


func _on_RestartButton_pressed():
	$Score.show()
	$GameOver.hide()
	get_tree().reload_current_scene()


func _on_MenuButton_pressed():

	$Score.show()
	$GameOver.hide()
	get_tree().change_scene("res://GameMenu.tscn")



func _on_QuitButton_pressed():
	get_tree().quit()


