import Foundation

struct car: Codable {
    var year: Int
    var brand: String
    var model: String
    var type: String
}

let unitToyota = car(year: 1986,brand: "Toyota",model: "AE86",type: "Coupe")
let unitBMW = car(year: 1992,brand: "BMW",model: "E30",type: "Sedan")
let unitSuzuki = car(year: 1998,brand: "Suzuki",model: "Esteem",type: "Sedan")

var carList: Array<car>  = [unitToyota, unitBMW, unitSuzuki]

if UserDefaults.standard.object(forKey: "SavedCarList") != nil{
    let storedObject: Data = UserDefaults.standard.object(forKey: "SavedCarList") as! Data
    let storedCar: [car] = try! PropertyListDecoder().decode([car].self, from: storedObject)
    carList = storedCar
}

var quit = 0

while quit == 0 {
    print("Choose option:")
    print("1. Show list")
    print("2. Add car")
    print("3. Delete car")
    print("4. Edit car")
    print("5. Quit\n")
    
    print("Your input:")
    let userInput = readLine()
    print("\n")
    
    switch userInput{
    case "1":
        var cnt = 1
        for i in carList{
            print(cnt,i.brand, i.model, i.type, i.year)
            cnt += 1
        }
        print("\n")
    case "2":
        print("Type car brand:")
        let inputBrand = readLine()
        print("Type car model:")
        let inputModel = readLine()
        print("Type car type:")
        let inputType = readLine()
        print("Type car year:")
        let inputYear = readLine()
        let inputCar = car(year: Int(inputYear!)!, brand: inputBrand!, model: inputModel!,type:inputType!)
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
        print(inputIndex + 1,carList[inputIndex].brand,carList[inputIndex].model,carList[inputIndex].type,carList[inputIndex].year)
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
        quit = 1
        print("Quit\n")
    default:
        quit = 1
        print("Wrong input\n")
        break
    }
    
    UserDefaults.standard.set(try! PropertyListEncoder().encode(carList),forKey: "SavedCarList")
}
