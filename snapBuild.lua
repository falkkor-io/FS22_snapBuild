----------------------------------------------------------------------------------------------------
--Author: Falkkor-----------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
--"Imitation is the sincerest form of flattery that mediocrity can pay to greatness."---------------
----------------------------------------------------------------------------------------------------

SnapBuild = {}
SnapBuild.active = false

function SnapBuild.prerequisitesPresent(specializations)
    return true
end

function SnapBuild:onButtonSnapBuild()
    SnapBuild.active = not SnapBuild.active
    self:updateMenuActionTexts()
end

function SnapBuild:registerMenuActionEvents()
    local _, eventId = nil
    _, eventId = self.inputManager:registerActionEvent(InputAction.SNAPBUILD, self, self.onButtonSnapBuild, false, true, false, true)

    self.inputManager:setActionEventTextPriority(eventId, GS_PRIO_VERY_LOW)
    self.inputManager:setActionEventTextVisibility(eventId, true)

    self.snapBuildButtonEvent = eventId

    table.insert(self.menuEvents, eventId)

    self:updateMenuActionTexts()
end

function SnapBuild:updateMenuActionTexts()
    if SnapBuild.active then
        self.inputManager:setActionEventText(self.snapBuildButtonEvent, g_i18n:getText("SNAPBUILD_ACTIVE"))
    else
        self.inputManager:setActionEventText(self.snapBuildButtonEvent, g_i18n:getText("SNAPBUILD_INACTIVE"))
    end
end

function SnapBuild:onLoad(superFunc, ...)
	if SnapBuild.active then
		-- print("Snap Build is On")
		local spec = self.spec_placement
		local xmlFile = self.xmlFile
		spec.positionSnapSize = math.abs(xmlFile:getValue("placeable.placement#placementPositionSnapSize", 0.5))
		spec.rotationSnapAngle = math.abs(xmlFile:getValue("placeable.placement#placementRotationSnapAngle", 45.0))
	else
		-- print("Snap Build is Off")
	end
end

ConstructionScreen.registerMenuActionEvents = Utils.appendedFunction(ConstructionScreen.registerMenuActionEvents, SnapBuild.registerMenuActionEvents)
ConstructionScreen.updateMenuActionTexts = Utils.appendedFunction(ConstructionScreen.updateMenuActionTexts, SnapBuild.updateMenuActionTexts)
if ConstructionScreen.onButtonSnapBuild == nil then
    ConstructionScreen.onButtonSnapBuild = SnapBuild.onButtonSnapBuild
end

PlaceablePlacement.onLoad = Utils.appendedFunction(PlaceablePlacement.onLoad, SnapBuild.onLoad)
