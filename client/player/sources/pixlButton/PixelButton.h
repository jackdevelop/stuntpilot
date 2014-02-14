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
		normalSprite : Ĭ�Ͼ���
		selectedSprite : ���¾���
		disabledSprite : ���þ���
	**/
	static PixelButton* create(std::string normalSprite,std::string selectedSprite , std::string disabledSprite);

	/**
		normalSprite : Ĭ�Ͼ���
		selectedSprite : ���¾���
		disabledSprite : ���þ���
		isZoomOnTouchDown : �Ƿ����Ŵ�
	**/
	static PixelButton* create(std::string normalSprite,std::string selectedSprite , std::string disabledSprite , bool isZoomOnTouchDown);

	/**
		srcName : ��Դ����
		isZoomOnTouchDown : �Ƿ����Ŵ�
	**/
	static PixelButton* create(std::string srcName , bool isZoomOnTouchDown = false);


	int clickX;
	int clickY;

	// Ĭ����Դ�ļ���
	string m_src;



	virtual void onEnter();
	virtual void onExit();

	virtual bool ccTouchBegan(CCTouch *pTouch, CCEvent *pEvent);
	virtual void ccTouchMoved(CCTouch *pTouch, CCEvent *pEvent);
	virtual void ccTouchEnded(CCTouch *pTouch, CCEvent *pEvent);
	virtual void ccTouchCancelled(CCTouch *pTouch, CCEvent *pEvent);
};
#endif