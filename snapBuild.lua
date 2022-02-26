----------------------------------------------------------------------------------------------------
--Author: Falkkor-----------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
--"Imitation is the sincerest form of flattery that mediocrity can pay to greatness."---------------
----------------------------------------------------------------------------------------------------

SnapBuild = {
    POSITION = 0,
    ROTATION = 0
}

function SnapBuild.prerequisitesPresent(specializations)
    return true
end

function SnapBuild:onButtonSnapBuildPosition()
    if SnapBuild.POSITION == 0 then 
        SnapBuild.POSITION = 0.5
    elseif SnapBuild.POSITION == 0.5 then 
        SnapBuild.POSITION = 1
    elseif SnapBuild.POSITION == 1 then 
        SnapBuild.POSITION = 2
    elseif SnapBuild.POSITION == 2 then 
        SnapBuild.POSITION = 3
    elseif SnapBuild.POSITION == 3 then 
        SnapBuild.POSITION = 4
    elseif SnapBuild.POSITION == 4 then 
        SnapBuild.POSITION = 5
    elseif SnapBuild.POSITION == 5 then 
        SnapBuild.POSITION = 0
    end
    self:updateMenuActionTexts()
end

function SnapBuild:onButtonSnapBuildRotation()
    if SnapBuild.ROTATION == 0 then
        SnapBuild.ROTATION = 30
    elseif SnapBuild.ROTATION == 30 then
        SnapBuild.ROTATION = 45
    elseif SnapBuild.ROTATION == 45 then
        SnapBuild.ROTATION = 60
    elseif SnapBuild.ROTATION == 60 then
        SnapBuild.ROTATION = 90
    elseif SnapBuild.ROTATION == 90 then
        SnapBuild.ROTATION = 0
    end
    self:updateMenuActionTexts()
end

function SnapBuild:registerMenuActionEventsPosition()
    local _, eventIdPosition = nil
    _, eventIdPosition = self.inputManager:registerActionEvent(InputAction.SNAPBUILD_POSITION, self, self.onButtonSnapBuildPosition, false, true, false, true)

    self.inputManager:setActionEventTextPriority(eventIdPosition, GS_PRIO_VERY_LOW)
    self.inputManager:setActionEventTextVisibility(eventIdPosition, true)

    self.snapBuildButtonEventPosition = eventIdPosition

    table.insert(self.menuEvents, eventIdPosition)

    self:updateMenuActionTexts()
end

function SnapBuild:registerMenuActionEventsRotation()
    local _, eventIdRotation = nil
    _, eventIdRotation = self.inputManager:registerActionEvent(InputAction.SNAPBUILD_ROTATION, self, self.onButtonSnapBuildRotation, false, true, false, true)

    self.inputManager:setActionEventTextPriority(eventIdRotation, GS_PRIO_VERY_LOW)
    self.inputManager:setActionEventTextVisibility(eventIdRotation, true)

    self.snapBuildButtonEventRotation = eventIdRotation

    table.insert(self.menuEvents, eventIdRotation)

    self:updateMenuActionTexts()
end

function SnapBuild:updateMenuActionTexts()
    self.inputManager:setActionEventText(self.snapBuildButtonEventPosition, g_i18n:getText("SNAPBUILD_POSITION"))
    self.inputManager:setActionEventText(self.snapBuildButtonEventRotation, g_i18n:getText("SNAPBUILD_ROTATION"))
end

function SnapBuild:onLoad(superFunc, ...)
    local spec = self.spec_placement
    local xmlFile = self.xmlFile
    spec.positionSnapSize = math.abs(xmlFile:getValue("placeable.placement#placementPositionSnapSize", SnapBuild.POSITION))
    spec.rotationSnapAngle = math.abs(xmlFile:getValue("placeable.placement#placementRotationSnapAngle", SnapBuild.ROTATION))
end

ConstructionScreen.registerMenuActionEvents = Utils.appendedFunction(ConstructionScreen.registerMenuActionEvents, SnapBuild.registerMenuActionEventsPosition)
ConstructionScreen.updateMenuActionTexts = Utils.appendedFunction(ConstructionScreen.updateMenuActionTexts, SnapBuild.updateMenuActionTexts)

if ConstructionScreen.onButtonSnapBuildPosition == nil then
    ConstructionScreen.onButtonSnapBuildPosition = SnapBuild.onButtonSnapBuildPosition
end

ConstructionScreen.registerMenuActionEvents = Utils.appendedFunction(ConstructionScreen.registerMenuActionEvents, SnapBuild.registerMenuActionEventsRotation)
ConstructionScreen.updateMenuActionTexts = Utils.appendedFunction(ConstructionScreen.updateMenuActionTexts, SnapBuild.updateMenuActionTexts)

if ConstructionScreen.onButtonSnapBuildRotation == nil then
    ConstructionScreen.onButtonSnapBuildRotation = SnapBuild.onButtonSnapBuildRotation
end

PlaceablePlacement.onLoad = Utils.appendedFunction(PlaceablePlacement.onLoad, SnapBuild.onLoad)
