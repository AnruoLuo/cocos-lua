local olua = require "olua"
local autoconf = require "autoconf"
local M = autoconf.typemod 'cocos2d_ui'
local typeconf = M.typeconf
local typedef = M.typedef

M.PATH = '../../frameworks/libxgame/src/lua-bindings'
M.INCLUDES = [[
#include "lua-bindings/lua_conv.h"
#include "lua-bindings/lua_conv_manual.h"
#include "lua-bindings/LuaCocosAdapter.h"
#include "xgame/xlua.h"
#include "cocos2d.h"
#include "ui/CocosGUI.h"
#include "ui/UIScrollViewBar.h"
]]
M.CHUNK = [[]]

M.MAKE_LUACLS = function (cppname)
    cppname = string.gsub(cppname, '^cocos2d::ui::', 'ccui.')
    cppname = string.gsub(cppname, "::", ".")
    return cppname
end

M.EXCLUDE_TYPE = require 'conf.exclude-type'
M.EXCLUDE_TYPE 'cocos2d::ui::PageViewIndicator'

typeconf 'cocos2d::ui::Widget::FocusDirection'
typeconf 'cocos2d::ui::Widget::PositionType'
typeconf 'cocos2d::ui::Widget::SizeType'
typeconf 'cocos2d::ui::Widget::TouchEventType'
typeconf 'cocos2d::ui::Widget::TextureResType'
typeconf 'cocos2d::ui::Widget::BrightStyle'

typeconf 'cocos2d::ui::Widget'
    .EXCLUDE_FUNC 'createInstance'
    .ATTR('getVirtualRenderer', {RET = '@addref(protectedChildren |)'})
    .CALLBACK {NAME = 'onFocusChanged', LOCAL = false}
    .CALLBACK {NAME = 'addTouchEventListener', NULLABLE = true, LOCAL = false}
    .CALLBACK {NAME = 'addClickEventListener', NULLABLE = true, LOCAL = false}
    .CALLBACK {NAME = 'addCCSEventListener', NULLABLE = true, LOCAL = false}

typeconf 'cocos2d::ui::Helper'
typeconf 'cocos2d::ui::Scale9Sprite::State'
typeconf 'cocos2d::ui::Scale9Sprite::RenderingType'
typeconf 'cocos2d::ui::Scale9Sprite'
typeconf 'cocos2d::ui::LayoutComponent::HorizontalEdge'
typeconf 'cocos2d::ui::LayoutComponent::VerticalEdge'
typeconf 'cocos2d::ui::LayoutComponent'
typeconf 'cocos2d::ui::LayoutParameter::Type'
typeconf 'cocos2d::ui::LayoutParameter'
typeconf 'cocos2d::ui::LinearLayoutParameter::LinearGravity'
typeconf 'cocos2d::ui::LinearLayoutParameter'
typeconf 'cocos2d::ui::RelativeLayoutParameter::RelativeAlign'
typeconf 'cocos2d::ui::RelativeLayoutParameter'
typeconf 'cocos2d::ui::Layout::Type'
typeconf 'cocos2d::ui::Layout::ClippingType'
typeconf 'cocos2d::ui::Layout::BackGroundColorType'

typeconf 'cocos2d::ui::Layout'
    .CALLBACK {NAME = 'onPassFocusToChild', NULLABLE = true, LOCAL = false}

typeconf 'cocos2d::ui::HBox'
typeconf 'cocos2d::ui::VBox'
typeconf 'cocos2d::ui::RelativeBox'

local WebView = typeconf 'cocos2d::ui::WebView'
WebView.DEFIF = '#ifdef CCLUA_HAVE_WEBVIEW'
WebView.CALLBACK {NAME = 'setOnShouldStartLoading', NULLABLE = true, LOCAL = false}
WebView.CALLBACK {NAME = 'setOnDidFinishLoading', NULLABLE = true, LOCAL = false}
WebView.CALLBACK {NAME = 'setOnDidFailLoading', NULLABLE = true, LOCAL = false}
WebView.CALLBACK {NAME = 'setOnJSCallback', NULLABLE = true, LOCAL = false}

local EventType = typeconf 'cocos2d::ui::VideoPlayer::EventType'
EventType.DEFIF = '#ifdef CCLUA_HAVE_VIDEOPLAYER'

local StyleType = typeconf 'cocos2d::ui::VideoPlayer::StyleType'
StyleType.DEFIF = '#ifdef CCLUA_HAVE_VIDEOPLAYER'

local VideoPlayer = typeconf 'cocos2d::ui::VideoPlayer'
VideoPlayer.DEFIF = '#ifdef CCLUA_HAVE_VIDEOPLAYER'
VideoPlayer.CALLBACK {
    NAME = 'addEventListener',
    TAG_MAKER = 'videoPlayerCallback',
    TAG_MODE = 'OLUA_TAG_REPLACE',
    NULLABLE = true,
    LOCAL = false,
}

typeconf 'cocos2d::ui::AbstractCheckButton'
    .ATTR('getRendererBackground', {RET = '@addref(protectedChildren |)'})
    .ATTR('getRendererBackgroundSelected', {RET = '@addref(protectedChildren |)'})
    .ATTR('getRendererFrontCross', {RET = '@addref(protectedChildren |)'})
    .ATTR('getRendererBackgroundDisabled', {RET = '@addref(protectedChildren |)'})
    .ATTR('getRendererFrontCrossDisabled', {RET = '@addref(protectedChildren |)'})

typeconf 'cocos2d::ui::TabHeader::EventType'

typeconf 'cocos2d::ui::TabHeader'
    .ATTR('getTitleRenderer', {RET = '@addref(protectedChildren |)'})

typeconf 'cocos2d::ui::TabControl::Dock'
typeconf 'cocos2d::ui::TabControl::EventType'

local TabControl = typeconf 'cocos2d::ui::TabControl'
TabControl.ATTR('removeTab', {RET = '@delref(protectedChildren ~)'})
TabControl.ATTR('getTabHeader', {RET = '@addref(protectedChildren |)'})
TabControl.ATTR('getTabContainer', {RET = '@addref(protectedChildren |)'})
TabControl.ATTR('insertTab', {ARG2 = '@addref(protectedChildren |)', ARG3 = '@addref(protectedChildren |)'})
TabControl.CALLBACK {
    NAME = 'setTabChangedEventListener',
    TAG_MAKER = 'tabChangedEventListener',
    TAG_MODE = 'OLUA_TAG_REPLACE',
    NULLABLE = true,
}

typeconf 'cocos2d::ui::ScrollView::Direction'
typeconf 'cocos2d::ui::ScrollView::EventType'

local ScrollView = typeconf 'cocos2d::ui::ScrollView'
ScrollView.ATTR('getInnerContainer', {RET = '@addref(protectedChildren |)'})
ScrollView.CALLBACK {
    NAME = 'addEventListener',
    TAG_MAKER = 'scrollViewCallback',
    TAG_MODE = 'OLUA_TAG_REPLACE',
    NULLABLE = true,
    LOCAL = false,
}

typeconf 'cocos2d::ui::ListView::Gravity'
typeconf 'cocos2d::ui::ListView::EventType'
typeconf 'cocos2d::ui::ListView::MagneticType'

local ListView = typeconf 'cocos2d::ui::ListView'
ListView.ATTR('pushBackCustomItem', {ARG1 = '@addref(children |)'})
ListView.ATTR('insertCustomItem', {ARG1 = '@addref(children |)'})
ListView.ATTR('removeLastItem', {RET = '@delref(children ~)'})
ListView.ATTR('removeItem', {RET = '@delref(children ~)'})
ListView.ATTR('removeAllItems', {RET = '@delref(children ~)'})
ListView.ATTR('getItem', {RET = '@addref(children |)'})
ListView.ATTR('getItems', {RET = '@addref(children |)'})
ListView.CALLBACK {
    FUNCS = {'void addEventListener(@nullable const std::function<void(Ref*, EventType)>& callback)'},
    TAG_MAKER = 'ListViewCallback',
    TAG_MODE = 'OLUA_TAG_REPLACE',
}

typeconf 'cocos2d::ui::LoadingBar::Direction'
typeconf 'cocos2d::ui::LoadingBar'
typeconf 'cocos2d::ui::PageView::EventType'
typeconf 'cocos2d::ui::PageView::TouchDirection'

local PageView = typeconf 'cocos2d::ui::PageView'
PageView.ATTR('addPage', {ARG1 = '@addref(children |)'})
PageView.ATTR('insertPage', {ARG1 = '@addref(children |)'})
PageView.ATTR('removePage', {ARG1 = '@delref(children |)'})
PageView.ATTR('removePageAtIndex', {RET = '@delref(children ~)'})
PageView.ATTR('removeAllPages', {RET = '@delref(children *)'})
PageView.CALLBACK {
    FUNCS = {'void addEventListener(@nullable const std::function<void(Ref*, PageView::EventType)>& callback)'},
    TAG_MAKER = 'PageViewCallback',
    TAG_MODE = 'OLUA_TAG_REPLACE',
}

typeconf 'cocos2d::ui::RichElement::Type'
typeconf 'cocos2d::ui::RichElement'
typeconf 'cocos2d::ui::RichElementText'
typeconf 'cocos2d::ui::RichElementImage'
typeconf 'cocos2d::ui::RichElementCustomNode'
typeconf 'cocos2d::ui::RichElementNewLine'
typeconf 'cocos2d::ui::RichText::WrapMode'
typeconf 'cocos2d::ui::RichText::HorizontalAlignment'

local RichText = typeconf 'cocos2d::ui::RichText'
RichText.EXCLUDE_FUNC 'setTagDescription'
RichText.EXCLUDE_FUNC 'initWithXML'
RichText.CALLBACK {
    NAME = 'createWithXML',
    TAG_MAKER = 'OpenUrlHandler',
    TAG_MODE = 'OLUA_TAG_REPLACE',
    TAG_STORE = 'return',
}

typeconf 'cocos2d::ui::ScrollViewBar'
typeconf 'cocos2d::ui::Slider::EventType'

local Slider = typeconf 'cocos2d::ui::Slider'
Slider.ATTR('getSlidBallNormalRenderer', {RET = '@addref(protectedChildren |)'})
Slider.ATTR('getSlidBallPressedRenderer', {RET = '@addref(protectedChildren |)'})
Slider.ATTR('getSlidBallDisabledRenderer', {RET = '@addref(protectedChildren |)'})
Slider.ATTR('getSlidBallRenderer', {RET = '@addref(protectedChildren |)'})
Slider.CALLBACK {
    NAME = 'addEventListener',
    TAG_MAKER = 'sliderCallback',
    TAG_MODE = 'OLUA_TAG_REPLACE',
    NULLABLE = true,
    LOCAL = false,
}

typeconf 'cocos2d::ui::Text::Type'
typeconf 'cocos2d::ui::Text'
typeconf 'cocos2d::ui::TextAtlas'
typeconf 'cocos2d::ui::TextBMFont'
typeconf 'cocos2d::ui::UICCTextField'
typeconf 'cocos2d::ui::TextField::EventType'

local TextField = typeconf 'cocos2d::ui::TextField'
TextField.CALLBACK {
    NAME = 'addEventListener',
    TAG_MAKER = 'textFieldCallback',
    TAG_MODE = 'OLUA_TAG_REPLACE',
    NULLABLE = true,
    LOCAL = false,
}

typeconf 'cocos2d::ui::Button'
    .ATTR('setTitleLabel', {ARG1 = '@addref(protectedChildren |)'})
    .ATTR('getTitleRenderer', {RET = '@addref(protectedChildren |)'})
    .ATTR('getTitleLabel', {RET = '@addref(protectedChildren |)'})
    .ATTR('getRendererNormal', {RET = '@addref(protectedChildren |)'})
    .ATTR('getRendererClicked', {RET = '@addref(protectedChildren |)'})
    .ATTR('getRendererDisabled', {RET = '@addref(protectedChildren |)'})

typeconf 'cocos2d::ui::CheckBox::EventType'

local CheckBox = typeconf 'cocos2d::ui::CheckBox'
CheckBox.CALLBACK {
    NAME ='addEventListener',
    TAG_MAKER = 'checkBoxCallback',
    TAG_MODE = 'OLUA_TAG_REPLACE',
    NULLABLE = true,
    LOCAL = false,
}

typeconf 'cocos2d::ui::RadioButton::EventType'

local RadioButton = typeconf 'cocos2d::ui::RadioButton'
RadioButton.CALLBACK {
    NAME = 'addEventListener',
    TAG_MAKER = 'radioButtonCallback',
    TAG_MODE = 'OLUA_TAG_REPLACE',
    NULLABLE = true,
    LOCAL = false,
}

typeconf 'cocos2d::ui::RadioButtonGroup::EventType'

local RadioButtonGroup = typeconf 'cocos2d::ui::RadioButtonGroup'
RadioButtonGroup.CALLBACK {
    NAME = 'addEventListener',
    TAG_MAKER = 'radioButtonCallback',
    TAG_MODE = 'OLUA_TAG_REPLACE',
    NULLABLE = true,
    LOCAL = false,
}

typeconf 'cocos2d::ui::ImageView'
typeconf 'cocos2d::ui::EditBoxDelegate::EditBoxEndAction'
typeconf 'cocos2d::ui::EditBoxDelegate'
typeconf 'cocos2d::ui::LuaEditBoxDelegate'
typeconf 'cocos2d::ui::EditBox::KeyboardReturnType'
typeconf 'cocos2d::ui::EditBox::InputMode'
typeconf 'cocos2d::ui::EditBox::InputFlag'
typeconf 'cocos2d::ui::EditBox'
    .ATTR('setDelegate', {ARG1 = '@addref(delegate ^)'})
    .ATTR('getDelegate', {RET = '@addref(delegate ^)'})

return M