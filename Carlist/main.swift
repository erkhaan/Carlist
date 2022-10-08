import Foundation

// MARK: - Properties

var needToQuit = false

enum Options: String {
    case show = "1"
    case add = "2"
    case delete = "3"
    case edit = "4"
    case quit = "5"
}

enum Edit: Int, CaseIterable {
    case brand = 1
    case model
    case type
    case year
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

private func wrongInput() {
    needToQuit = true
    print("Wrong input\n")
}

private func userInteraction() {
    guard
        let input = readLine(),
        let option = Options(rawValue: input)
    else {
        wrongInput()
        return
    }
    print()
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

func printCar(with index: Int, _ car: Car) {
    print(index + 1, car.brand, car.model, car.type, car.year)
}

private func printCarList() {
    guard !carList.isEmpty else {
        print("No cars in list\n")
        return
    }
    for (index, car) in carList.enumerated() {
        printCar(with: index, car)
    }
    print()
}

private func userInput(_ property: String) -> String? {
    print("Type car \(property):")
    guard let input = readLine() else {
        return nil
    }
    return input
}

private func addCar() {
    guard
        let brand = userInput("brand"),
        let model = userInput("model"),
        let type = userInput("type"),
        let inputYear = userInput("year"),
        let year = Int(inputYear)
    else {
        wrongInput()
        return
    }
    let inputCar = Car(
        year: year,
        brand: brand,
        model: model,
        type: type)
    carList.append(inputCar)
    print("Car was added\n")
}

private func deleteCar() {
    guard !carList.isEmpty else {
        print("Nothing to delete\n")
        return
    }
    print("What car to delete?:")
    guard
        let inputIndex = readLine(),
        let index = Int(inputIndex),
        (1...carList.count).contains(index)
    else {
        wrongInput()
        return
    }
    carList.remove(at: index - 1)
    print("Deleted\n")
}

private func editCar() {
    guard
        let index = selectedCar(),
        let property = selectedProperty()
    else {
        return
    }
    settingProperty(at: index, property)
}

/// selection of car by index
private func selectedCar() -> Int? {
    print("What car to edit?:")
    guard
        let inputIndex = readLine(),
        let inputInt = Int(inputIndex),
        (1...carList.count).contains(inputInt)
    else {
        wrongInput()
        return nil
    }
    let index = inputInt - 1
    print("You selected:")
    printCar(with: index, carList[index])
    return index
}

/// selection of property
private func selectedProperty() -> Edit? {
    print("What do you want to change?:")
    print("1. Brand")
    print("2. Model")
    print("3. Type")
    print("4. Year")
    guard
        let inputChange = readLine(),
        let change = Int(inputChange),
        (1...Edit.allCases.count).contains(change)
    else {
        wrongInput()
        return nil
    }
    let edit = Edit(rawValue: change)
    return edit
}

/// setting new value of selected property
private func settingProperty(at i: Int, _ edit: Edit) {
    print("Type your edit:")
    guard let input = readLine() else {
        wrongInput()
        return
    }
    switch edit {
    case .brand:
        carList[i].brand = input
    case .model:
        carList[i].model = input
    case .type:
        carList[i].type = input
    case .year:
        guard let input = Int(input) else {
            wrongInput()
            return
        }
        carList[i].year = input
    }
    print("New value:")
    printCar(with: i, carList[i])
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
