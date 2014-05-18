local singleInstance
local EditText = class("EditText", function()
    return display.newNode()
end)

--[[
转载《唐门世界》
在cocos中的文本框，一般用的是CCEditBox，点击的时候，会弹出一个对话框，然后在对话框中输入内容，体验很不好
还有一个叫CCTextFieldTTF，虽然不弹出对话框，但是封装的太少，没法直接用，所以就搞出这个控件，方便使用的。


使用：
 local text1 = EditText.new( {
        width = 340 , 
        height = 70 , 
        size = 32 , 
        hintText = "帐号" , 
        text = "1021299802@qq.com" ,
    }) 
    text2:setPosition(ccp(100, display.cy - 60))
    self:addChild(text1)
    
    
]]
-- 构造方法
function EditText:ctor(params)
    -- 设置默认参数
    params = params or {} 
    self.width = params.width or 100 
    self.height = params.height or 22 
    self.size = params.size or 28 
    self.text = params.text or "" 
    self.isPassword = params.isPassword or false
    params.font = params.font or "Arial"
    params.hintText = params.hintText or "" 
    params.textColor = params.textColor or display.COLOR_GREEN
    params.hintColor = params.hintColor or display.COLOR_WHITE

    -- 文本框控件
    self.node = display.newNode() 
    self.textfield = CCTextFieldTTF:textFieldWithPlaceHolder(params.hintText, params.font, self.size) 
    self.textfield:setString(self.text) 
    self:setAnchPos(self.textfield, 0, 0, 0, 0.5) 
    self.textfield:setColor(params.textColor) 
    self.textfield:setColorSpaceHolder(params.hintColor) 
    self.node:addChild(self.textfield) 

    -- 光标
    self.cursor = display.newSprite("cursor.png")
    self:setAnchPos(self.cursor, self.size/2, 0, 1, 0.5) 
    self.node:addChild(self.cursor) 
    self.cursor:setVisible(false) 
    self.cursor:setScaleY((self.height - 20)/self.cursor:getContentSize().height)

    -- 滚动条
    self.sx, self.sy = 10, self.size - 10
    self.scrollView_ = CCScrollView:create()
    self.scrollView_:setViewSize(CCSize(self.width, self.height))
    self.scrollView_:setContentSize(CCSize(self.width, self.height))
    self.scrollView_:setContainer(self.node)
    self.scrollView_:setContentOffset(ccp(self.sx, self.sy))
    self.scrollView_:setDirection(kCCScrollViewDirectionHorizontal) 
    self:addChild(self.scrollView_)
    self.scrollView_:setCascadeBoundingBox(CCRect(0, 0, self.width, self.height))

    -- 点击事件
    CCNodeExtend.extendButton(self, {onClick = function (x, y)
        self:startInput()
    end})
    self:setTouchEnabled(true)
end

-- 工具方法：用于设置控件的位置
function EditText:setAnchPos(node, x, y, ax, ay)
    node:setPosition(ccp(x, y))
    node:setAnchorPoint(ccp(ax, ay))
end

function EditText:startInput() 
    self:stopInput()
    if singleInstance and singleInstance.stopInput and singleInstance ~= self then
        singleInstance:stopInput()
    end
    singleInstance = self
    self.sx = -10

    local function refreshFun( isForce ) 
        local curStr = self.textfield:getString() 
        if self.text ~= curStr or isForce then 
            self.text = curStr 
            if not self.isPassword then
                self.textfield:setString(self.text) 
            else
               self.textfield:setString(string.rep("*", self.textfield:getCharCount())) 
            end
            local curWidth =  self.textfield:getContentSize().width 
            if  curWidth < self.width then 
                self:setAnchPos( self.textfield , 0 , 0 , 0 , 0.5 ) 
            else 
                self:setAnchPos( self.textfield , self.width , 0 , 1 , 0.5 ) 
            end 
            local x = curWidth > self.width and self.width + self.size/2  or curWidth + self.size/2
            local scrollX = x - self.scrollView_:getViewSize().width
            scrollX = (scrollX > 0 and scrollX + 5) or 0 + self.sx
            if curStr == "" then
                x = 5
            end
            self:setAnchPos(self.cursor, x, 0, 1, 0.5) 
            -- 滚动条的位置
            self.scrollView_:setContentOffset(ccp(-scrollX, self.sy), false)
        end 
    end 
    local delayTime = 0.5 
    local function blinkFun() 
        if self.cursor then 
            local actionAry = CCArray:create() 
            actionAry:addObject( 
                CCCallFunc:create( 
                    function()  
                        xpcall( function() self.cursor:setVisible( true ) end , function() self.cursor = nil end ) 
                    end ) 
                ) 
            actionAry:addObject( CCDelayTime:create( delayTime ) ) 
            actionAry:addObject( CCCallFunc:create( function()  xpcall( function() self.cursor:setVisible( false ) end , function() self.cursor = nil end ) end ) )
            actionAry:addObject( CCDelayTime:create( delayTime  ) ) 
            actionAry:addObject( CCCallFunc:create( blinkFun ) ) 
            self.node:runAction( CCSequence:create( actionAry ) ) 
        end 
    end 
    blinkFun() 
    self.handle = CCDirector:sharedDirector():getScheduler():
        scheduleScriptFunc( function() xpcall( function() refreshFun() end , function()end )  end , 0.1 , false ) 
    refreshFun( true ) 
    self.textfield:attachWithIME() 
end 

function EditText:stopInput( isClear ) 
    self:setAnchPos(self.textfield, 0, 0, 0, 0.5) 
    if isClear then 
        self.textfield:setString("") 
    end 
    self.textfield:detachWithIME() 
    self.cursor:setVisible(false) 
    transition.stopTarget(self.node) 
end 

function EditText:getString() 
    return self.textfield:getString() 
end 

function EditText:getCharCount() 
    return self.textfield:getCharCount() 
end 

return EditText 