/**
* The Sudoku Game!!! Boost your brain!!!
* Author -  Sujan Dhakal (dhakals@lafayette.edu)
			Utsav Shrestha (shresthu@lafayette.edu)
			Lafayette College '21
* Version - 1.0
* 
* Released under MIT License
* Copyright © 2021 Sujan Dhakal, Utsav Shrestha.
* Permission is hereby granted, free of charge, to any person obtaining a copy of this software 
* and associated documentation files (the "Software"), to deal in the Software without restriction, 
* including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
* and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, 
* subject to the following conditions:
* 
* The above copyright notice and this permission notice shall be included in all copies or 
* substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
* INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE 
* AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, 
* DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/


class Sudoku{
	var isGameOver:Bool = false
	var isChangeAble = [[Bool]](repeating: [Bool](repeating:true, count: 9), count: 9)
	var sudoku = [[Character]]()

	init(sudoku: [[Character]]){
		self.sudoku = sudoku
		for i in 0...8 {
			for j in 0...8 {
				if (sudoku[i][j] != "_"){
					isChangeAble[i][j] = false
				}
			}
		}
	}

	func runGame(){
		while(!isGameOver){
			print("")
			printGame()
			print("")
			var inputValid:Bool = false
			var row:Int?
			var col:Int?
			var num:Int?
			while(!inputValid){
				print("Please enter the row number, column number and value for the cell. ")
				print("Format: row_num col_num value ==> Eg: 1 1 5")
				if let input = readLine(){
					let inputNumber = input.split(separator: " ")
					if (inputNumber.count != 3){
						print("Incorrect Input. Please Enter Correct Input.")
					} else {
						row = Int(inputNumber[0])
						col = Int(inputNumber[1])
						num = Int(inputNumber[2])
						if (row == nil || col == nil || num == nil){
							print("Incorrect Input. Please Enter Correct Input.")
						} else {
							if (!checkInputNum(row:row!, col:col!, num:num!)){
								print("Invalid number. Please enter the number between 1 to 9.")
							} else {
								inputValid = true
							}
						}
					}	
				}
			}
			print(updateSudoku(row:row!, col:col!, num:num!))
			if (isSolved()){
				isGameOver = true
				print("")
				print("Congratulations!!! You Solved the Sudoku.")
				print("")
				printGame()
				print("")
				print("********************************************************************")
				print("")
			}
		}
	}

	func checkInputNum(row: Int, col: Int, num: Int) -> Bool{
		if ((row >= 1 && row <= 9) && (col >= 1 && col <= 9) && (num >= 1 && num <= 9)) {
			return true
		}
		return false;
	}

	func isValidNum(row: Int, col: Int, num: Int) -> Int{
		let toInsert:Character = Character(String(num))
		
		// check row Validity
		if (sudoku[row-1].contains(toInsert)){
			return -1
		}

		// check col Validity
		for r in 0...8{
			if (sudoku[r][col-1]==toInsert){
				return -2
			}
		}

		// check 3*3 grid validity
		var gridSet = Set<Character>() 
        let br:Int = ((row-1)/3) * 3;
        let bc:Int = ((col-1)/3) * 3;

        for r in br...br+2{
        	for c in bc...bc+2{
        		if (gridSet.contains(toInsert)){
        			return -3
        		} else {
        			gridSet.insert(sudoku[r][c])
        		}
        	}
        }

		return 0
	}

	func updateSudoku(row: Int, col: Int, num: Int) -> String{
		if (isChangeAble[row-1][col-1]){
			let validity:Int = isValidNum(row:row, col:col, num:num)
			if (validity == -1) {
				return "Repeated Number in the same row."
			} else if (validity == -2){
				return "Repeated Number in the same column."
			}  else if (validity == -3){
				return "Repeated Number in the 3*3 grid."
			} else {
				sudoku[row-1][col-1] = Character(String(num))
				return "Updated \(num) at (\(row), \(col))"
			}
		}
		return "Predefined cell cannot be updated."
	}

	func printGame(){
		for row in sudoku{
			var r:String = ""
			for col in row {
				r += String(col) + " "
			}
			print(r)
		}
	}

	func isSolved() -> Bool{
		for row in sudoku{
			if (row.contains("_")){
				return false
			}
		}
		return true
	}
}

class Main{
	var level:Int = 1

	var sudoku1:[[Character]] = [["_", "2", "7", "1", "5", "4", "3", "9", "6"],
								["9", "6", "5", "3", "2", "7", "1", "4", "8"],
								["3", "4", "1", "6", "8", "9", "7", "5", "2"],
								["5", "9", "3", "4", "6", "8", "2", "7", "1"],
								["4", "7", "2", "5", "1", "3", "6", "8", "9"],
								["6", "1", "8", "9", "7", "2", "4", "3", "5"],
								["7", "8", "6", "2", "3", "5", "9", "1", "4"],
								["1", "5", "4", "7", "9", "6", "8", "2", "3"],
								["2", "3", "9", "8", "4", "1", "5", "6", "7"]]

	var sudoku2:[[Character]] = [["8", "_", "7", "1", "5", "4", "3", "9", "6"],
								["9", "6", "5", "3", "2", "7", "1", "4", "8"],
								["3", "4", "1", "6", "8", "9", "7", "5", "2"],
								["5", "9", "3", "4", "6", "8", "2", "7", "1"],
								["4", "7", "2", "5", "1", "3", "6", "8", "9"],
								["6", "1", "8", "9", "7", "2", "4", "3", "5"],
								["7", "8", "6", "2", "3", "5", "9", "1", "4"],
								["1", "5", "4", "7", "9", "6", "8", "2", "3"],
								["2", "3", "9", "8", "4", "1", "5", "6", "7"]]

	var sudoku3:[[Character]] = [["8", "2", "_", "1", "5", "4", "3", "9", "6"],
								["9", "6", "5", "3", "2", "7", "1", "4", "8"],
								["3", "4", "1", "6", "8", "9", "7", "5", "2"],
								["5", "9", "3", "4", "6", "8", "2", "7", "1"],
								["4", "7", "2", "5", "1", "3", "6", "8", "9"],
								["6", "1", "8", "9", "7", "2", "4", "3", "5"],
								["7", "8", "6", "2", "3", "5", "9", "1", "4"],
								["1", "5", "4", "7", "9", "6", "8", "2", "3"],
								["2", "3", "9", "8", "4", "1", "5", "6", "7"]]

	var sudoku4:[[Character]] = [["8", "2", "7", "_", "5", "4", "3", "9", "6"],
								["9", "6", "5", "3", "2", "7", "1", "4", "8"],
								["3", "4", "1", "6", "8", "9", "7", "5", "2"],
								["5", "9", "3", "4", "6", "8", "2", "7", "1"],
								["4", "7", "2", "5", "1", "3", "6", "8", "9"],
								["6", "1", "8", "9", "7", "2", "4", "3", "5"],
								["7", "8", "6", "2", "3", "5", "9", "1", "4"],
								["1", "5", "4", "7", "9", "6", "8", "2", "3"],
								["2", "3", "9", "8", "4", "1", "5", "6", "7"]]

	var sudoku5:[[Character]] = [["8", "2", "7", "1", "_", "4", "3", "9", "6"],
								["9", "6", "5", "3", "2", "7", "1", "4", "8"],
								["3", "4", "1", "6", "8", "9", "7", "5", "2"],
								["5", "9", "3", "4", "6", "8", "2", "7", "1"],
								["4", "7", "2", "5", "1", "3", "6", "8", "9"],
								["6", "1", "8", "9", "7", "2", "4", "3", "5"],
								["7", "8", "6", "2", "3", "5", "9", "1", "4"],
								["1", "5", "4", "7", "9", "6", "8", "2", "3"],
								["2", "3", "9", "8", "4", "1", "5", "6", "7"]]
	func run(){
		print("")
		print("Hello, Welcome to Sudoku Game.")
		print("")
		while(level<=5){
			if (level==1){
				print("Level: Easy")
				let sudoku = Sudoku(sudoku:sudoku1)
				sudoku.runGame()
				level += 1
			} else if (level==2){
				print("Level: Medium")
				let sudoku = Sudoku(sudoku:sudoku2)
				sudoku.runGame()
				level += 1
			} else if (level==3){
				print("Level: Hard")
				let sudoku = Sudoku(sudoku:sudoku3)
				sudoku.runGame()
				level += 1
			} else if (level==4){
				print("Level: Super Hard")
				let sudoku = Sudoku(sudoku:sudoku4)
				sudoku.runGame()
				level += 1
			} else {
				print("Level: Einstein Hard")
				let sudoku = Sudoku(sudoku:sudoku5)
				sudoku.runGame()
				level += 1
			}
		}
		print("Thank you for playing Sudoku. Hope you enjoyed!!!")
	}
}

let main = Main()
main.run()