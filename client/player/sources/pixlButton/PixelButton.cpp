#include "PixelButton.h"
//#include "CCScale9Sprite.h"

using namespace std;
using namespace cocos2d;
USING_NS_CC_EXT;


bool PixelButton::init()
{
	if(CCControlButton::init())
	{
		m_src = "";
		setTouchEnabled(true);
		setAnchorPoint(CCPointZero);
		return true;
	}
	return false;
}
PixelButton* PixelButton::create(std::string normalSprite,std::string selectedSprite , std::string disabledSprite)
{
	PixelButton* m_PixelButton = (PixelButton*)PixelButton::create();
	m_PixelButton->m_src = normalSprite;
	m_PixelButton->setBackgroundSpriteForState(CCScale9Sprite::create(normalSprite.c_str()) , CCControlStateNormal);
	m_PixelButton->setBackgroundSpriteForState(CCScale9Sprite::create(selectedSprite.c_str()) , CCControlStateHighlighted);
	m_PixelButton->setBackgroundSpriteForState(CCScale9Sprite::create(disabledSprite.c_str()) , CCControlStateDisabled);
	return m_PixelButton;
}

PixelButton* PixelButton::create(std::string normalSprite,std::string selectedSprite , std::string disabledSprite , bool isZoomOnTouchDown)
{
	PixelButton* m_PixelButton = PixelButton::create(normalSprite , selectedSprite , disabledSprite);
	m_PixelButton->setZoomOnTouchDown(isZoomOnTouchDown);
	return m_PixelButton;
}

PixelButton* PixelButton::create(std::string srcName , bool isZoomOnTouchDown)
{
	string normalSprite = srcName;
	string selectedSprite = srcName;
	string disabledSprite = srcName;
	return PixelButton::create(normalSprite.append("_normal.png") , selectedSprite.append("_selector.png") , disabledSprite.append("_selector.png") , isZoomOnTouchDown);
}

void PixelButton::onEnter()
{
	CCControlButton::onEnter();
}

void PixelButton::onExit()
{
	CCControlButton::onExit();
}

bool PixelButton::ccTouchBegan(CCTouch *pTouch, CCEvent *pEvent)
{
	CCSize cSize = this->getContentSize();
	CCPoint point = this->getAnchorPointInPoints();
	CCRect cRect = CCRectMake(-point.x, -point.y, cSize.width,cSize.height);
	if (!cRect.containsPoint(convertTouchToNodeSpaceAR(pTouch)))
	{
		return false;
	}

	ccColor4B c = {0, 0, 0, 0};
	CCSize winSize = CCDirector::sharedDirector()->getWinSize();
	CCPoint touchPoint = pTouch->getLocationInView();
	point = ccp(cSize.width - point.x,cSize.height- point.y);
	CCPoint pos(this->getPositionX() - point.x,winSize.height-this->getPositionY()- point.y);
	CCPoint localPoint = ccp(touchPoint.x - pos.x,touchPoint.y -pos.y);
	unsigned int x = localPoint.x, y = localPoint.y;
	clickX=x,clickY=y;
	CCImage * img = new CCImage();
	//CCLog("touch坐标 %d - %d", touchPoint.x, touchPoint.y);
	//CCLog("转化坐标 %d - %d", pos.x, pos.y);
	CCLog("%d - %d" , x , y);
	
	img->initWithImageFileThreadSafe(CCFileUtils::sharedFileUtils()->fullPathForFilename(m_src.c_str()).c_str());
	unsigned char *data_ = img->getData();

	unsigned int *pixel = (unsigned int *)data_;
	pixel = pixel + (y * (int)this->getContentSize().width)* 1 + x * 1;
	if (!pixel)
	{
		CCLog("------------------error---------------");
		return false;
	}
	c.r = *pixel & 0xff;
	c.g = (*pixel >> 8) & 0xff;
	c.b = (*pixel >> 16) & 0xff;
	c.a = (*pixel >> 24) & 0xff;
	if (c.a = (*pixel >> 24) & 0xff) {
		CCControlButton::ccTouchBegan(pTouch , pEvent);
		//clickX=x;
		//clickY=y;
		return true;
	}else
	{
		return false;
	}
}
void PixelButton::ccTouchMoved(CCTouch *pTouch, CCEvent *pEvent)
{
	CCControlButton::ccTouchMoved(pTouch , pEvent);
}
void PixelButton::ccTouchEnded(CCTouch *pTouch, CCEvent *pEvent)
{
	CCControlButton::ccTouchEnded(pTouch , pEvent);
}
void PixelButton::ccTouchCancelled(CCTouch *pTouch, CCEvent *pEvent)
{
	CCControlButton::ccTouchCancelled(pTouch , pEvent);
}