require_relative 'residential_controller'
RSpec.describe residential_controller, "#columnClass", "#CallButton", "#FloorRequestButton", "#Door" do

Column = residential_controller.Column
Elevator = residential_controller.Elevator
CallButton = residential_controller.CallButton
FloorRequestButton = residential_controller.FloorRequestButton
Door = residential_controller.Door

def scenario = (column, requestedFloor, direction, destination)
    tempColumn = copy.deepcopy(column)
    selectedElevator = tempColumn.requestElevator(requestedFloor, direction)
    pickedUpUser = False
    if selectedElevator.currentFloor == requestedFloor
        pickedUpUser = True
    end
    selectedElevator.requestFloor(destination)
    moveAllElevators(tempColumn)

    for i in range tempColumn.elevatorList.length
        if tempColumn.elevatorList[i].ID == selectedElevator.ID
            tempColumn.elevatorList[i].currentFloor = selectedElevator.currentFloor
        end
            i += 1
    end

    results = {
        "tempColumn": tempColumn,
        "selectedElevator": selectedElevator,
        "pickedUpUser": pickedUpUser
    }
    return results

    column1 = Column 1, 10, 2
end

    #Makes the elevators who already have requests move before continuing with the scenario
def moveAllElevators(column)
    for elevator in column.elevatorList
        while elevator.floorRequestList.lenght(!= 0)
            elevator.move()
        end
    end
end

def test_Instantiates_a_Column_with_valid_attributes()
    
    raise "This is wrong" unless expr
    assert column1.type(Column)
    assert column1.ID == 1
    assert column1.status != None
    assert column1.elevatorList.lenght(2)
    assert type(column1.elevatorList[0]) is Elevator
    assert len(column1.callButtonList ) is 18
    assert type(column1.callButtonList [0]) is CallButton

