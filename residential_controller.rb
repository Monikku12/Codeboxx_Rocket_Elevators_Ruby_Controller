$floorRequestButtonID = 1
$callButtonID = 1

class Column 
    def initialize(_id, _amountOfFloors, _amountOfElevators) 
        @ID = 1
        @status = 'online'
        @elevatorList = []
        @callButtonList = []
        createElevators(_amountOfFloors, _amountOfElevators)
        createCallButtons(_amountOfFloors)
    end

        # ---------------------------------Methods--------------------------------------------
    def createCallButtons( _amountOfFloors)
        buttonFloor = 1            
        for i in _amountOfFloors
            if i < _amountOfFloors # If it's not the last floor
                callButton = CallButton.new(callButtonID, buttonFloor, 'Up') #id, status, floor, direction
                @callButtonList.push(callButton)
                callButtonID += 1
            if i > 1 #If it's not the first floor
                callButton = CallButton.new(callButtonID, buttonFloor, 'Down') #id, status, floor, direction
                @callButtonList.push(callButton)
                callButtonID += 1
                buttonFloor += 1
            end
        end
    end

    def createElevators(_amountOfFloors, _amountOfElevators)
        for _amountOfElevators in _amountOfElevators
            elevator = Elevator.new(_amountOfElevators + 1, _amountOfFloors)
            @elevatorList.push(elevator)
        end
        puts elevator
    end

        # Simulate when a user press a button outside the elevator
    def requestElevator(floor, direction)
        elevator = findElevator(floor, direction)
        elevator.floorRequestList.append(floor)
        elevator.move()
        elevator.operateDoors()
        return elevator
    end
    
        # We use a score system depending on the current elevators state. Since the bestScore and the referenceGap are
        # higher values than what could be possibly calculated, the first elevator will always become the default bestElevator,
        # before being compared with to other elevators. If two elevators get the same score, the nearest one is prioritized.
    def findElevator(requestedFloor, requestedDirection)
        bestElevator = None
        bestScore = 5
        referenceGap = 10000000
        bestElevatorInformations = {'bestElevator':bestElevator, 'bestScore':bestScore, 'referenceGap':referenceGap}
        
        for elevator in @elevatorList
            # The elevator is at my floor and going in the direction I want
            if (requestedFloor == elevator.currentFloor and elevator.status == 'stopped' and requestedDirection == elevator.direction)
                bestElevatorInformations = checkIfElevatorIsBetter(1, elevator, bestElevatorInformations, requestedFloor)
                # The elevator is lower than me, is coming up and I want to go up
            elif (requestedFloor > elevator.currentFloor and elevator.direction == 'up' and requestedDirection == elevator.direction)
                bestElevatorInformations = checkIfElevatorIsBetter(2, elevator, bestElevatorInformations, requestedFloor)
                # The elevator is higher than me, is coming down and I want to go down
            elif (requestedFloor < elevator.currentFloor and elevator.direction == 'down' and requestedDirection == elevator.direction)
                bestElevatorInformations = checkIfElevatorIsBetter(2, elevator, bestElevatorInformations, requestedFloor)
                # The elevator is idle
            elif (elevator.status == 'idle')
                bestElevatorInformations = checkIfElevatorIsBetter(3, elevator, bestElevatorInformations, requestedFloor)
                # The elevator is not available, but still could take the call if nothing better is found
            else
                bestElevatorInformations = checkIfElevatorIsBetter(4, elevator, bestElevatorInformations, requestedFloor)
            end
        end
        elevator = bestElevatorInformations.get('bestElevator')
        return elevator
    end

    def checkIfElevatorIsBetter(scoreToCheck, newElevator, bestElevatorInformations, floor)
        if (scoreToCheck < bestElevatorInformations['bestScore'])
            bestElevatorInformations['bestScore'] = scoreToCheck
            bestElevatorInformations['bestElevator'] = newElevator
            bestElevatorInformations['referenceGap'] = (newElevator.currentFloor - floor).abs
        elif (bestElevatorInformations['bestScore'] == scoreToCheck)
            gap = (newElevator.currentFloor - floor).abs
            if (bestElevatorInformations['referenceGap'] > gap)
                bestElevatorInformations['bestElevator'] = newElevator
                bestElevatorInformations['referenceGap'] = gap
            end
        end
        return bestElevatorInformations
    end
end

class Elevator
    def initialize(_id, _amountOfFloors)
        @ID = _id
        @status = 'idle'
        @currentFloor = 1
        @amountOfFloors = _amountOfFloors
        @direction = None
        @door = Door.new(_id) 
        @floorRequestButtonList = []
        @floorRequestList = []
        createFloorRequestButtons(_amountOfFloors)
    end

    def createFloorRequestButtons(_amountOfFloors)
        buttonFloor = 1    
        for _amountOfFloors in _amountOfFloors
            floorRequestButton = FloorRequestButton.new(floorRequestButtonID, buttonFloor)
            @floorRequestButtonList.push(floorRequestButton)
            buttonFloor += 1
            floorRequestButtonID += 1
        end 
    end

        # Simulate when a user press a button inside the elevator
    def requestFloor(floor)
        @floorRequestList.push(floor)
        move()
        operateDoors()
    end

    def move()
        while @floorRequestList.length( 0)
            destination = @floorRequestList[0]
            @status = 'moving'
            if @currentFloor < destination
                @direction = 'up'
                sortFloorList()
                while @currentFloor < destination
                    @currentFloor += 1
                    screenDisplay = @currentFloor
                end
            elif @currentFloor > destination
                @direction = 'down'
                sortFloorList()
                while @currentFloor > destination
                    @currentFloor -= 1
                    screenDisplay = @currentFloor
                end
            end
            @status = 'stopped'
            @floorRequestList.pop()
        end
        @status = 'idle'
    end

    def sortFloorList()
        if @direction == 'up'
            @floorRequestList.sort
        else
            @floorRequestList.reverse
        end
    end

    def operateDoors()
        @door.status = 'opened'
        obstruction = None
        if self != 'overweight'
            @door.status = 'closing'
            if obstruction == False
                @door.status = 'closed'
            else
                operateDoors
            end
        else
            while self.isOverweight
                operateDoors
            end
        end
    end
end

class CallButton
    def initialize( _id, _floor, _direction)
        @ID = _id
        @status = 'OFF'
        @floor = _floor
        @direction = _direction
    end
end

class FloorRequestButton
    def initialize(_id, _floor)
        @ID = _id
        @status = 'OFF'
        @floor = _floor
    end
end

class Door
    def initialize(_id)
        @ID = _id
        @status = 'closed'
    end
end

# ******************

# To run your own simulation, uncomment the TEMPLATE section below and enter your own value in the different fields. 

# TEMPLATE - To be adjust
# templateColumn = Column(1, <numberOfFloors>, <numberOfElevators>)
# templateColumn.elevatorList[0].currentFloor = <yourFirstElevatorCurrentFloor>
# templateColumn.elevatorList[1].currentFloor = <yourSecondElevatorCurrentFloor>
# elevator = templateColumn.requestElevator(<yourCurrentFloor>, '<yourRequestedDirection>')
# elevator.requestFloor(<yourRequestedFloorNumber>)

#  ******************

templateColumn = Column. new("1", "10", "2")
templateColumn.elevatorList[0].currentFloor = 10
templateColumn.elevatorList[1].currentFloor = 3
elevator = templateColumn.requestElevator("1", 'up')
elevator.requestFloor(6)
end