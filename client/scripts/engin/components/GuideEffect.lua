local GuideEffect = {}

----灰色背景用colorLayer来显示，中间亮的区域，可以用混合模式将layer挖去一部分，然后渲染到CCRenderTexture上，具体做法如下：
--        local function setBlend(obj, src, dst)
--            local b = ccBlendFunc:new()
--            b.src = src
--            b.dst = dst
--            obj:setBlendFunc(b)
--        end
--                --背景
--        local myLayer = display.newColorLayer(ccc4(0,0,0,230))
--                --创建遮罩图片
--        local pMask
--        pMask = display.newSprite("你需要挖去的图片.png")
--        pMask:setScaleX(pd.w/30)
--        pMask:setScaleY(pd.h/30)--设置一下缩放
--        pMask:setAnchorPoint(ccp(0,0))
--        pMask:setPosition(pd.x, pd.y)
--                --设置混合模式
--        setBlend(pMask, GL_ZERO, GL_ONE_MINUS_SRC_ALPHA)
--        --创建干净的画板
--        local pRt = CCRenderTexture:create(CONFIG_SCREEN_WIDTH, CONFIG_SCREEN_HEIGHT)
--        self:addChild(pRt);
--        pRt:setPosition(CONFIG_SCREEN_WIDTH/2, CONFIG_SCREEN_HEIGHT/2)
--                --开始绘制
--        pRt:begin()
--        myLayer:visit()
--        if pData then
--            pMask:visit()
--        end
--        pRt:endToLua()




return GuideEffect;