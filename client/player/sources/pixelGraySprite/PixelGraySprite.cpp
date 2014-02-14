#include "PixelGraySprite.h"

#include <math.h>
#include <stdio.h>
#include <string.h>

extern "C" {
#include "tolua_fix.h"
}

NS_MAP_GAME_LUABINDING_BEGIN

PixelGraySprite *PixelGraySprite::create(void)
{
    PixelGraySprite *runtime = new PixelGraySprite();
    return runtime;
}

PixelGraySprite::PixelGraySprite(void)
: L(NULL)
{
    L = CCLuaEngine::defaultEngine()->getLuaStack()->getLuaState();
}

PixelGraySprite::~PixelGraySprite(void)
{
    CCLOG("~~ PixelGraySprite");
}



//根据现有CCSprite，变亮和变灰
CCSprite* PixelGraySprite::graylightWithCCSprite(CCSprite* oldSprite,bool isLight)
{
    //CCSprite转成CCimage
   CCPoint p = oldSprite->getAnchorPoint();
    oldSprite->setAnchorPoint(ccp(0,0));
    CCRenderTexture *outTexture = CCRenderTexture::create((int)oldSprite->getContentSize().width,(int)oldSprite->getContentSize().height);
    outTexture->begin();
    oldSprite->visit();
    outTexture->end();
    oldSprite->setAnchorPoint(p);
    
    CCImage* finalImage = outTexture->newCCImage();
    unsigned char *pData = finalImage->getData();
    int iIndex = 0;
    
    if(isLight)
    {
        for (int i = 0; i < finalImage->getHeight(); i ++)
        {
            for (int j = 0; j < finalImage->getWidth(); j ++)
            {
                // highlight
                int iHightlightPlus = 50;
                int iBPos = iIndex;
                unsigned int iB = pData[iIndex];
                iIndex ++;
                unsigned int iG = pData[iIndex];
                iIndex ++;
                unsigned int iR = pData[iIndex];
                iIndex ++;
                //unsigned int o = pData[iIndex];
                iIndex ++;  //原来的示例缺少
                iB = (iB + iHightlightPlus > 255 ? 255 : iB + iHightlightPlus);
                iG = (iG + iHightlightPlus > 255 ? 255 : iG + iHightlightPlus);
                iR = (iR + iHightlightPlus > 255 ? 255 : iR + iHightlightPlus);
                //            iR = (iR < 0 ? 0 : iR);
                //            iG = (iG < 0 ? 0 : iG);
                //            iB = (iB < 0 ? 0 : iB);
                pData[iBPos] = (unsigned char)iB;
                pData[iBPos + 1] = (unsigned char)iG;
                pData[iBPos + 2] = (unsigned char)iR;
            }
        }
    }else{
        for (int i = 0; i < finalImage->getHeight(); i ++)
        {
            for (int j = 0; j < finalImage->getWidth(); j ++)
            {
                // gray
                int iBPos = iIndex;
                unsigned int iB = pData[iIndex];
                iIndex ++;
                unsigned int iG = pData[iIndex];
                iIndex ++;
                unsigned int iR = pData[iIndex];
                iIndex ++;
                //unsigned int o = pData[iIndex];
                iIndex ++; //原来的示例缺少
                unsigned int iGray = 0.3 * iR + 0.4 * iG + 0.2 * iB;
                pData[iBPos] = pData[iBPos + 1] = pData[iBPos + 2] = (unsigned char)iGray;
            }
        }
    }
    
    CCTexture2D *texture = new CCTexture2D;
    texture->initWithImage(finalImage);
    CCSprite* newSprite = CCSprite::createWithTexture(texture);
    delete finalImage;
    texture->release();
    return newSprite;
}



NS_MAP_GAME_LUABINDING_END