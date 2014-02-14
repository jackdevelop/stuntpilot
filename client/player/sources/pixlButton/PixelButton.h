#ifndef __PIXEL_BUTTON_H_
#define __PIXEL_BUTTON_H_


#include "CCControlButton.h"
#include "CCScale9Sprite.h"


using namespace std;
using namespace cocos2d;


class PixelButton :public cocos2d::extension::CCControlButton
{
public:
	virtual bool init();
	CREATE_FUNC(PixelButton);

	/**
		normalSprite : 默认精灵
		selectedSprite : 按下精灵
		disabledSprite : 禁用精灵
	**/
	static PixelButton* create(std::string normalSprite,std::string selectedSprite , std::string disabledSprite);

	/**
		normalSprite : 默认精灵
		selectedSprite : 按下精灵
		disabledSprite : 禁用精灵
		isZoomOnTouchDown : 是否点击放大
	**/
	static PixelButton* create(std::string normalSprite,std::string selectedSprite , std::string disabledSprite , bool isZoomOnTouchDown);

	/**
		srcName : 资源名称
		isZoomOnTouchDown : 是否点击放大
	**/
	static PixelButton* create(std::string srcName , bool isZoomOnTouchDown = false);


	int clickX;
	int clickY;

	// 默认资源文件名
	string m_src;



	virtual void onEnter();
	virtual void onExit();

	virtual bool ccTouchBegan(CCTouch *pTouch, CCEvent *pEvent);
	virtual void ccTouchMoved(CCTouch *pTouch, CCEvent *pEvent);
	virtual void ccTouchEnded(CCTouch *pTouch, CCEvent *pEvent);
	virtual void ccTouchCancelled(CCTouch *pTouch, CCEvent *pEvent);
};
#endif