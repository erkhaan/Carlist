import Foundation

// MARK: - Properties

let unitToyota = Car(
    year: 1986,
    brand: "Toyota",
    model: "AE86",
    type: "Coupe")
let unitBMW = Car(
    year: 1992,
    brand: "BMW",
    model: "E30",
    type: "Sedan")
let unitSuzuki = Car(
    year: 1998,
    brand: "Suzuki",
    model: "Esteem",
    type: "Sedan")

var carList = [
    unitToyota,
    unitBMW,
    unitSuzuki]

var needToQuit = false

enum Options: String {
    case show = "1"
    case add = "2"
    case delete = "3"
    case edit = "4"
    case quit = "5"
}

// MARK: - Functions

private func load() {
    if UserDefaults.standard.object(forKey: "SavedCarList") != nil {
        let storedObject = UserDefaults.standard.object(forKey: "SavedCarList") as! Data
        let storedCar = try! PropertyListDecoder().decode([Car].self, from: storedObject)
        carList = storedCar
    }
}

private func save() {
    UserDefaults.standard.set(try! PropertyListEncoder().encode(carList), forKey: "SavedCarList")
}

private func userInteraction() {
    let userInput = readLine()
    print()
    guard
        let input = userInput,
        let option = Options(rawValue: input)
    else {
        needToQuit = true
        print("Wrong input\n")
        return
    }
    switch option {
    case .show:
        printCarList()
    case .add:
        addCar()
    case .delete:
        deleteCar()
    case .edit:
        editCar()
    case .quit:
        needToQuit = true
        print("Quit\n")
    }
}

private func printCarList() {
    for (index, elem) in carList.enumerated() {
        print(index + 1, elem.brand, elem.model, elem.type, elem.year)
    }
    print()
}

private func addCar() {
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
        type: inputType!)
    carList.append(inputCar)
    print("Car was added\n")
}

private func deleteCar() {
    print("What car to delete?:")
    let inputIndex = readLine()!
    carList.remove(at: Int(inputIndex)! - 1)
    print("Deleted\n")
}

private func editCar() {
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
    switch inputChange {
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
}

private func printDescription() {
    print("Choose option:")
    print("1. Show list")
    print("2. Add car")
    print("3. Delete car")
    print("4. Edit car")
    print("5. Quit\n")
    print("Your input:")
}

// MARK: - Main

while !needToQuit {
    load()
    printDescription()
    userInteraction()
    save()
}
