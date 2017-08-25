var frameName="";
var orderFrameName='';
var rong='';
var msgList=new Array();
var IDList=[];
//var ajaxUrl='http://192.168.1.100:8002';
//var ajaxUrl='http://www.api.ings.online';
var ajaxUrl='http://www.api.ings.org.cn';
var imgUrl='http://www.ings.org.cn';
var ImgUrl='http://www.ings.org.cn';
function openWin(name) {
    localStorage.setItem('isFrame',false);
    api.openWin({
        name: name,
        url: name + '.html',
        vScrollBarEnabled: false
    });
}
function openMainWin(name) {
    localStorage.setItem('isFrame',false);
    api.openWin({
        name: name,
        url:'html/'+ name + '.html',
        vScrollBarEnabled: false
    });
}
function openSchoolWin(name,Country) {
    api.openWin({
        name: name,
        url: name + '.html',
        pageParam: {
            Country:Country
        }
    });
}
function orderWin(name,frameName) {
    localStorage.setItem("orderFrameName",frameName );
    api.openWin({
        name: name,
        url: name + '.html',
        vScrollBarEnabled: false
    });
}
function indexWin() {
    localStorage.setItem("orderFrameName",'index_window' );
    api.openWin({
        name: 'index_window',
        url:'../index_window.html',
        vScrollBarEnabled: false
    });
}
function openFrame(name) {
    if(localStorage.getItem('frameName')==='org-win' ||localStorage.getItem('frameName')==='sub-win' ){
       /* api.execScript({
            name: 'root',
            frameName: localStorage.getItem('frameName'),
            script: 'refresh();'
        });*/
    }
    localStorage.setItem('frameName',name);
    localStorage.setItem('isFrame',true);
    var body=$api.byId('body');
    /*$api.fixStatusBar(body);
    $api.fixIos7Bar(body);*/
    var footer = $api.byId('footer');
    var footerPos = $api.offset(footer);
    api.openFrame ({
        name:name,
        url:name+ '.html',
        rect:{
            x:0,
            y:0,
            w:'auto',
            h:api.frameHeight-30
        },
        bounces: false,
        opaque: false,
        vScrollBarEnabled:false,
        hScrollBarEnabled:false
    });
}
function openMainFrame(name) {
    if(localStorage.getItem('frameName')==='org-win' ||localStorage.getItem('frameName')==='sub-win' ){
        /* api.execScript({
         name: 'root',
         frameName: localStorage.getItem('frameName'),
         script: 'refresh();'
         });*/
    }

    if(name=='home-win'){
        addUserBrowserLog('主页','')
    }else if(name=='org-win'){
        addUserBrowserLog('机构列表页','','')
    } else if(name=='schoollist'){
        addUserBrowserLog('学校列表页','','')
    }else{
        addUserBrowserLog('个人中心页','','')
    }
    localStorage.setItem('frameName',name);
    localStorage.setItem('isFrame',true);
    var body=$api.byId('body');
    /*$api.fixStatusBar(body);
    $api.fixIos7Bar(body);*/
    var footer = $api.byId('footer');
    var footerPos = $api.offset(footer);
    api.openFrame ({
        name:name,
        url:'html/'+name+ '.html',
        rect:{
            x:0,
            y:0,
            w:'auto',
            h:api.frameHeight-50
        },
        bounces: false,
        opaque: false,
        reload:true,
        vScrollBarEnabled:false,
        hScrollBarEnabled:false
    });
}
function openSearchMainFrame(name,type,val,txt) {
    if(name=='home-win'){
        addUserBrowserLog('主页','')
    }else if(name=='org-win'){
        addUserBrowserLog('机构列表页','','')
    } else if(name=='schoollist'){
        addUserBrowserLog('学校列表页','','')
    }else{
        addUserBrowserLog('个人中心页','','')
    }
    localStorage.setItem('frameName',name);
    localStorage.setItem('isFrame',true);
    var body=$api.byId('body');
    /*$api.fixStatusBar(body);
     $api.fixIos7Bar(body);*/
    var footer = $api.byId('footer');
    var footerPos = $api.offset(footer);
    api.openFrame ({
        name:name,
        url:'html/'+name+ '.html',
        rect:{
            x:0,
            y:0,
            w:'auto',
            h:api.frameHeight-50
        },
        bounces: false,
        opaque: false,
        reload:true,
        vScrollBarEnabled:false,
        hScrollBarEnabled:false,
        pageParam: {
            funType: type,
            value:val,
            txt:txt
        }
    });
}
var orderFrameType=0;
function orderFrame(type){
    var headerH=0;
    if(api.statusBarAppearance){
        headerH=44+20;
    }else{
        headerH=44
    }
    closeFrame(orderFrameName);
    if(type===0)
        localStorage.setItem("orderFrameName","appointmentlist" );
    else if(type===1)
        localStorage.setItem("orderFrameName","obligationlist" );
    else if(type===2)
        localStorage.setItem("orderFrameName","evaluatelist" );
    else
        localStorage.setItem("orderFrameName","allorder" );
    api.openFrame ({
        name:localStorage.getItem("orderFrameName"),
        url:localStorage.getItem("orderFrameName")+ '.html',
        rect:{
            x:0,
            y:(40+headerH)+'px',
            w:'auto',
            h:api.frameHeight-40-headerH
        },
        bounces: false,
        opaque: false,
        vScrollBarEnabled:false,
        hScrollBarEnabled:false,
        pageParam: {
            userId: userId
        }
    });
}
function closeWin() {
    api.closeWin();
}
function closeFrame(name) {
    api.closeFrame({name:name});
}
function changeCity(){
    if(localStorage.getItem('city'))
        $('.city').html(localStorage.getItem('city'));
}


function htmldecode(s){
    var div = document.createElement('div');
    div.innerHTML = s;
    return div.innerHTML;
}
var AddUrl=function(str,reg){
    this.time=0,
        this.str=str,
        this.returnStr='',
        this.regStr='',
        this.addStr=ImgUrl,
        this.reg=reg,
        this.strLength=this.str.length,
        this.lastIndex=0,
        this.nowIndex=0,
        this.changeStr=function(){
            this.regStr='';
            this.regStr=this.reg.exec(this.str);
            if( this.regStr){
                this.nowIndex=this.regStr.index+this.regStr[0].length;
                this.returnStr+=this.str.substring(0,this.nowIndex)+this.addStr;
                this.str=this.str.substring(this.nowIndex,this.strLength-1);
                this.strLength=this.str.length;
                this.changeStr();
            }else{
                this.returnStr=this.returnStr+this.str;
                return this.returnStr;
            }
        }
}
function checkLogin(){
    if(!$api.getStorage('UserInfo')){
        api.alert({
            title: '提示',
            msg: '请先登录!'
        }, function(ret, err) {
            openWin('login');
        });
        return false;
    }
    return true;

}
var EARTH_RADIUS = 6378137.0;    //单位M
var PI = Math.PI;

function getRad(d){
    return d*PI/180.0;
}
function getFlatternDistance(lat1,lng1,lat2,lng2){
    var f = getRad((lat1 + lat2)/2);
    var g = getRad((lat1 - lat2)/2);
    var l = getRad((lng1 - lng2)/2);

    var sg = Math.sin(g);
    var sl = Math.sin(l);
    var sf = Math.sin(f);

    var s,c,w,r,d,h1,h2;
    var a = EARTH_RADIUS;
    var fl = 1/298.257;

    sg = sg*sg;
    sl = sl*sl;
    sf = sf*sf;

    s = sg*(1-sl) + (1-sf)*sl;
    c = (1-sg)*(1-sl) + sf*sl;

    w = Math.atan(Math.sqrt(s/c));
    r = Math.sqrt(s*c)/w;
    d = 2*w*a;
    h1 = (3*r -1)/2/c;
    h2 = (3*r +1)/2/s;

    return d*(1 + fl*(h1*sf*(1-sg) - h2*(1-sf)*sg));
}
function isBarAppearance(){
    if(api.statusBarAppearance){
            $('header').css({
                paddingTop:'20px',
                height:'65px'
            });
    }
}
function HTMLEncode(html) {
    var temp = document.createElement("div");
    (temp.textContent != null) ? (temp.textContent = html) : (temp.innerText = html);
    var output = temp.innerHTML;
    temp = null;
    return output;
}
function HTMLDecode(text) {
    var temp = document.createElement("div");
    temp.innerHTML = text;
    var output = temp.innerText || temp.textContent;
    temp = null;
    return output;
}
function toshare(val,price){
    localStorage.setItem('shareNum',val);
    localStorage.setItem('price',price);
    $(".am-share").addClass("am-modal-active");
    if($(".sharebg").length>0){
        $(".sharebg").addClass("sharebg-active");
    }else{
        $("body").append('<div class="sharebg"></div>');
        $(".sharebg").addClass("sharebg-active");
    }
    $(".sharebg-active,.share_btn").click(function(){
        $(".am-share").removeClass("am-modal-active");
        setTimeout(function(){
            $(".sharebg-active").removeClass("sharebg-active");
            $(".sharebg").remove();
        },300);
    })
}
function toDownShare(val,price,id){
    var  userInfo= $api.getStorage('UserInfo');
    if(Number(price)>=1000){
        checkIsInvite( userInfo.User_ID);
    }
    var backprice=0;
    api.ajax({
        url : ajaxUrl+'/userOrder/OrderInfoList',
        method : 'get',
        data : {
            values : {
                userId : userInfo.User_ID,
                orderNo:val
            }
        }
    },function(ret,err){
        if(ret.Status===1){
            backprice=parseInt(ret.Entity[0].BackPrice)
            localStorage.setItem('shareNum',val);
            localStorage.setItem('price',backprice);
            $(".am-share").addClass("am-modal-active");
            if($(".sharebg").length>0){
                $(".sharebg").addClass("sharebg-active");
            }else{
                $("body").append('<div class="sharebg"></div>');
                $(".sharebg").addClass("sharebg-active");
            }
            $(".sharebg-active,.share_btn").click(function(){
                $(".am-share").removeClass("am-modal-active");
                setTimeout(function(){
                    $(".sharebg-active").removeClass("sharebg-active");
                    $(".sharebg").remove();
                },300);
            })
        }else{
            alert('分享失败')
        }

    })

}
function checkIsInvite(id){
    api.ajax({
        url:ajaxUrl+'/users/getUserOnly',
        method:'get',
        data:{
            values:{
                userId:id
            }
        }
    },function(ret,err) {
        if(ret.Status==1){
            if(ret.Entity.Recommender && ret.Entity.Recommender!='' ){
                api.ajax({
                    url:ajaxUrl+'/user/UserBalanceOperation',
                    method:'post',
                    data:{
                        values:{
                            "UserId":ret.Entity.Recommender,
                            "Price": 55,
                            "ChannelName": "邀请奖励",
                            "ChannelCode": "",
                            "OperationType": 0
                        }
                    }
                },function(rets,errs) {
                })
            }
        }
    })
}
function closeBox(){
    $(event.target).parent().addClass('disno');
    localStorage.setItem("orderFrameName",'evaluatelist')
}
function getLocalTime(nS) {
    return new Date(parseInt(nS) ).toLocaleString().replace(/:\d{1,2}$/,' ');
}
function addUserBrowserLog(pageName,type,token){
    var userInfo = $api.getStorage('UserInfo');
    if(userInfo){
        if(token)
            token=token
        else
            token=""
        api.ajax({
            url:ajaxUrl+'/user/UserBrowseLog',
            method:'post',
            data:{
                values:{
                    "UserId": userInfo.User_ID,
                    "PageName": pageName,
                    "UserType": type ? type:0,
                    "UserToken": token
                }
            }
        },function(ret,err) {

        })
    }else{
    }

}