-- Velocity and acceleration on path
nominalVel = 0.25
nominalAcc = 0.5

-- Get object and script handles
target = sim.getObjectHandle("Target#0")
connector = sim.getObjectHandle("Connector#0")
belt1_script = sim.getScriptHandle("ConveyorBelt#5")

-- Initialize variables
pickupDummy2 = -1
releasePath2 = -1

function sysCall_threadmain()
    while true do
	-- Pause script until a signal is applied on integer signal "objectAvailable"
        sim.waitForSignal("objectAvailable2")
	-- Obtain current pickupPath-handle
        path2 = sim.getObjectHandle("pickupPath2#")
	-- Follow the pickupPath
        sim.followPath(target,path2,3,0,nominalVel,nominalAcc)
	-- Wait one second to mimic a connection process
        sim.wait(1)
	-- Connect the connector to pickupDummy
        sim.setLinkDummy(connector,pickupDummy2)
    	-- Set link type
        sim.setObjectInt32Param(connector,sim.dummyintparam_link_type,sim.dummy_linktype_dynamics_loop_closure)
	-- Follow back the pickup path
        sim.followPath(target,path2,3,1,-nominalVel,-nominalAcc)
	-- Follow release path
        sim.followPath(target,releasePath2,3,0,nominalVel,nominalAcc)
	-- Wait 0.25 seconds 
        sim.wait(0.25)
	-- Disconnect pickupDummy from connector
        sim.setLinkDummy(connector,-1)
	-- Follow back releasePath to "idle" position
        sim.followPath(target,releasePath2,3,1,-nominalVel,-nominalAcc)
    end
end


