import Foundation

struct Car: Codable {
    var year: Int
    var brand: String
    var model: String
    var type: String
}

let unitToyota = Car(
    year: 1986,
    brand: "Toyota",
    model: "AE86",
    type: "Coupe"
)
let unitBMW = Car(
    year: 1992,
    brand: "BMW",
    model: "E30",
    type: "Sedan"
)
let unitSuzuki = Car(
    year: 1998,
    brand: "Suzuki",
    model: "Esteem",
    type: "Sedan"
)

var carList: Array<Car>  = [
    unitToyota,
    unitBMW,
    unitSuzuki
]

if UserDefaults.standard.object(forKey: "SavedCarList") != nil {
    let storedObject: Data = UserDefaults.standard.object(forKey: "SavedCarList") as! Data
    let storedCar: [Car] = try! PropertyListDecoder().decode([Car].self, from: storedObject)
    carList = storedCar
}

var needToQuit = false

func printCarList() {
    for (index, elem) in carList.enumerated() {
        print(index + 1, elem.brand, elem.model, elem.type, elem.year)
    }
    print("\n")
}

while needToQuit == false {
    print("Choose option:")
    print("1. Show list")
    print("2. Add car")
    print("3. Delete car")
    print("4. Edit car")
    print("5. Quit\n")

    print("Your input:")
    let userInput = readLine()
    print("\n")

    switch userInput {
    case "1":
        printCarList()
    case "2":
        print("Type car brand:")
        let inputBrand = readLine()
        print("Type car model:")
        let inputModel = readLine()
        print("Type car type:")
        let inputType = readLine()
        print("Type car year:")
        let inputYear = readLine()
        let inputCar = Car(
            year: Int(inputYear!)!,
            brand: inputBrand!,
            model: inputModel!,
            type: inputType!
        )
        carList.append(inputCar)
        print("Car was added\n")
    case "3":
        print("What car to delete?:")
        let inputIndex = readLine()!
        carList.remove(at: Int(inputIndex)! - 1)
        print("Deleted\n")
    case "4":
        print("What car to edit?:")
        let inputIndex = Int(readLine()!)! - 1
        print("You selected:")
        print(inputIndex + 1, carList[inputIndex].brand, carList[inputIndex].model, carList[inputIndex].type, carList[inputIndex].year)
        print("What do you want to change?:")
        print("1. Brand")
        print("2. Model")
        print("3. Type")
        print("4. Year")
        let inputChange = Int(readLine()!)
        print("Type your edit:")
        switch inputChange{
        case 1:
            let input = readLine()
            carList[inputIndex].brand = input!
        case 2:
            let input = readLine()
            carList[inputIndex].model = input!
        case 3:
            let input = readLine()
            carList[inputIndex].type = input!
        case 4:
            let input = readLine()
            carList[inputIndex].year = Int(input!)!
        default:
            print("Wrong input")
            break
        }
        print("Edit was done\n")
    case "5":
        needToQuit = true
        print("Quit\n")
    default:
        needToQuit = true
        print("Wrong input\n")
        break
    }

    UserDefaults.standard.set(try! PropertyListEncoder().encode(carList), forKey: "SavedCarList")
}
