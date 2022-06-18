



class Column 
    attr_accessor :elevatorList, :callButtonList, :status, :ID
    def initialize(_id, _amountOfFloors, _amountOfElevators) 
        @ID = 1
        @status = "online"
        @elevatorList = []
        @callButtonList = []
        createElevators(_amountOfFloors, _amountOfElevators)
        createCallButtons(_amountOfFloors)
    end


        # ---------------------------------Methods--------------------------------------------
        createCallButtons( _amountOfFloors)







        def createElevators(_amountOfFloors, _amountOfElevators)
            for _amountOfElevators in _amountOfElevators [do]
                elevator = Elevator(_amountOfElevators+1, _amountOfFloors)
                @elevatorList.push(elevator)
            end
        end



        # Simulate when a user press a button outside the elevator
        requestElevator(floor, direction)







        # We use a score system depending on the current elevators state. Since the bestScore and the referenceGap are
        # higher values than what could be possibly calculated, the first elevator will always become the default bestElevator,
        # before being compared with to other elevators. If two elevators get the same score, the nearest one is prioritized.
        findElevator(requestedFloor, requestedDirection)










        checkIfElevatorIsBetter(scoreToCheck, newElevator, bestElevatorInformations, floor):


end



class Elevator:
    attr_accessor :elevatorList, :callButtonList, :status, :ID
    def initialize(_id, _amountOfFloors)
        @ID = _id
        @status = "idle"
        @currentFloor = 1
        @amountOfFloors = _amountOfFloors
        @direction = None
        @door = Door(_id) 
        @floorRequestButtonList = []
        @floorRequestList = []
        createFloorRequestButtons(_amountOfFloors)
    end

        createFloorRequestButtons(_amountOfFloors)






        # Simulate when a user press a button inside the elevator
        requestFloor(floor)




        move()









        sortFloorList()









        operateDoors()







end

class CallButton:
    def initialize( _id, _floor, _direction):
        @ID = _id
        @status = "OFF"
        @floor = _floor
        @direction = _direction
    end
end

class FloorRequestButton:
    def initialize(_id, _floor):
        @ID = _id
        @status = "OFF"
        @floor = _floor
    end
end

class Door:
    def initialize(_id):
        @ID = _id
        @status = "closed"
    end
end

# ******************

# To run your own simulation, uncomment the TEMPLATE section below and enter your own value in the different fields. 

# TEMPLATE - To be adjust
# templateColumn = Column(1, <numberOfFloors>, <numberOfElevators>)
# templateColumn.elevatorList[0].currentFloor = <yourFirstElevatorCurrentFloor>
# templateColumn.elevatorList[1].currentFloor = <yourSecondElevatorCurrentFloor>
# elevator = templateColumn.requestElevator(<yourCurrentFloor>, "<yourRequestedDirection>")
# elevator.requestFloor(<yourRequestedFloorNumber>)

#  ******************


