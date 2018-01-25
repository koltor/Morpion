#cette classe viens regrouper toute les caracteristique d'un joueur
class Player

	attr_accessor :nom, :forme, :etat
	#lors de la creation on viens demender le nom, la forme ainsi que son tour de jeu
	def initialize(pseudo,forme,etat)
		@nom = pseudo
		@forme = forme
		@etat = etat
	end

	#cette fonction est appeler lors de son tour de jeu
	#on viens demender la ligne et la colonne que le joueur veux remplir
	def tourDejeu()
		puts "A moi de jouer (#{nom})"
		print "ligne :"
		x = gets.chomp()
		print "colonne :"
		y = gets.chomp()
		return [x.to_i - 1,y.to_i - 1,@forme]
	end
end




# la classe Boardcorrespond au plateau de jeu
class Board

	attr_accessor :plateau

	def initialize() # on initialise des cases pour pouvoir gerer l'affichage
		@plateau = [[" "," "," "],[" "," "," "],[" "," "," "]]
		aff()
	end

	#la fonction d'affichage viens tout simplement afficher le plateau de jeu
	def aff()
			print @plateau[0][0],"|", @plateau[0][1],"|",@plateau[0][2]
			puts
			puts "-----"
			print @plateau[1][0],"|", @plateau[1][1],"|",@plateau[1][2]
			puts
			puts "-----"
			print @plateau[2][0],"|", @plateau[2][1],"|",@plateau[2][2]
			puts
	end

	# cet fonction viens moldifier une case tu terrain
	def actu(status)
		if @plateau[status[0]][status[1]] == " "
			@plateau[status[0]][status[1]] = status[2]
			aff()
		else
			puts"case déja remplis veillez rejouer"
			return false
		end
	end
	# liste des differentes façon de gagner
	def verif
		if ((@plateau[0][0] == @plateau[0][1] && @plateau[0][1] == @plateau[0][2]) && @plateau[0][0] != " ") 	
			return true
		end
		if ((@plateau[1][0] == @plateau[1][1] && @plateau[1][1] == @plateau[1][2]) && @plateau[1][0] != " ")  
			return true
		end
		if ((@plateau[2][0] == @plateau[2][1] && @plateau[2][1] == @plateau[2][2]) && @plateau[2][0] != " ")	
			return true
		end
	  if ((@plateau[0][0] == @plateau[1][0] && @plateau[1][0] == @plateau[2][0]) && @plateau[0][0] != " ")	
	  	return true
	  end
	  if ((@plateau[0][1] == @plateau[1][1] && @plateau[1][1] == @plateau[2][1]) && @plateau[0][1] != " ")	
	  	return true
	  end
		if ((@plateau[0][2] == @plateau[1][2] && @plateau[1][2] == @plateau[2][2]) && @plateau[0][2] != " ")	
			return true
		end
		if ((@plateau[0][0] == @plateau[1][1] && @plateau[1][1] == @plateau[2][2]) && @plateau[0][0] != " ")	
			return true
		end
		if ((@plateau[2][0] == @plateau[1][1] && @plateau[1][1] == @plateau[0][2]) && @plateau[2][0] != " ")	
			return true
		end
		return false
	end
end




#la classe principale du jeu
class Game

		def initialize()
			i = 1
			j = 0 
				while i <= 2
					puts "donne moi le nom du perso " + i.to_s
					nom = gets.chomp()
					puts "donne moi la forme que tu a choisi"
					forme = gets.chomp()
					if i == 1
						puts "veut tu commencer ? O/y"
						etat = gets.chomp()
						player1 = Player.new(nom,forme,etat)
					else
						if etat == "O"
							etat = "y"
							j = 1
						else
							etat = "O"
						end
						player2= Player.new(nom,forme,etat)
					end	
					i += 1
				end
				annonce(player1.nom, player2.nom)
				player = [player1, player2]
				board = Board.new()
				jeu(player,board,j)
		end


		#fonction d'annonce
		def annonce(nom1,nom2)
			puts "nous allons assiter au combat du siècle"
			sleep(2)
			puts "un combat de #{nom1} contre #{nom2}"
			sleep(1)
			puts "c'est partie"
		end

		#fonction du tour de jeu 
		def jeu(player, board, j)
			t = 0
			while ((player[0].etat != "v" && player[1].etat != "v") && t < 9) 
				if (board.actu(player[j%2].tourDejeu())) == false
					j -= 1
					t -= 1
				end
				if board.verif == true
					player[j%2].etat = "v"
					puts "fin du game"
				end
				j += 1
				t += 1
			end
			if t == 9
				puts "match nul"
			else
				puts "il y a un gagnant " + player[j%2].nom
			end
		end
end

#lancement d'une partie
game = Game.new()