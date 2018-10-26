<!DOCTYPE html>
<html>
<head>
	<title>咖啡机移动端</title>
	<meta charset="UTF-8">
	<meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="${staticPath}/css/adapter.css">
    <link rel="stylesheet" href="${staticPath}/css/weui.css">
    <script type="text/javascript" src="${staticPath}/js/vue.js"></script>
    <script type="text/javascript" src="${staticPath}/js/weui.js"></script>
    <script type="text/javascript" src="${staticPath}/js/axios.js"></script>
    <script type="text/javascript" src="${staticPath}/js/server.js"></script>
</head>
<body>
	<div id="app">
        <h2>绑定手机号</h2>
        <p class="main-tip">输入手机号</p>  
        <input type="number" step="1" name="phoneNumber" id="phoneNumber" v-model="phoneNumber" placeholder="请输入手机号"></input> 
        <p class="sub-tip" ref="subTip">请输入本人手机号绑定微信账号</p> 
        <p class="main-tip">验证码</p>  
        <div id="captchaBox">
            <input type="number" step="1" name="captcha" id="captcha" placeholder="请输入验证码" v-model="captchaNumber"></input>
            <Button id="getCaptcha" ref="getCaptcha" @click="getCaptcha" disabled>获取验证码</Button>
        </div>  
        <p class="sub-tip-always" ref="captchaSubTip"></p> 
        <Button id="confirm" ref="confirm" disabled @click="confirm">确认绑定</Button> 
	</div>
</body>
</html>

<script>
	var app = new Vue({
        el: '#app',
        data(){
            return{
                phoneNumber: "",
                captchaNumber:"",
                authenticCode:"",
                countdown:60,
                checkPhoneNumber:false,
            }
        },
        watch:{
            phoneNumber:function(val){
                var reg = /^(0|86|17951)?(13[0-9]|15[012356789]|166|17[3678]|18[0-9]|14[57])[0-9]{8}$/
                if (reg.test(val)){
                    this.$refs.subTip.innerHTML = "请输入本人手机号绑定微信账号"
                    this.$refs.subTip.style.color = "#999999"
                    this.checkPhoneNumber = true
                    this.$refs.getCaptcha.removeAttribute("disabled")
                    this.$refs.getCaptcha.style.color="#A05A28"
                }else{
                    if (val.length<11){
                        this.$refs.subTip.innerHTML = "手机号码长度不足"
                        this.$refs.subTip.style.color = "#999999"
                    }else{
                        this.$refs.subTip.innerHTML = "手机号码不正确，请重新输入"
                        this.$refs.subTip.style.color = "#A05A28"
                    }
                    this.checkPhoneNumber = false
                    this.$refs.captchaSubTip.innerHTML = ""
                    this.$refs.getCaptcha.setAttribute("disabled","")
                    this.$refs.confirm.setAttribute("disabled","")
                    this.$refs.getCaptcha.style.color="#999999"
                    this.$refs.confirm.style.opacity="0.5"
                }
            },
            captchaNumber:function(val){
                if (val.length!=6){
                    this.$refs.captchaSubTip.innerHTML = "验证码长度不正确"
                    this.$refs.confirm.style.opacity="0.5"
                    this.$refs.confirm.setAttribute("disabled","")
                }else{
                    if (this.captchaNumber==this.authenticCode){
                        this.$refs.captchaSubTip.innerHTML = ""
                        this.$refs.confirm.style.opacity="1"
                        this.$refs.confirm.removeAttribute("disabled")
                    } else {
                        this.$refs.captchaSubTip.innerHTML = "验证码填写有误，请重新输入"
                        this.$refs.confirm.style.opacity="0.5"
                        this.$refs.confirm.setAttribute("disabled","")
                    }
                }
            }
        },
        methods:{
            getCaptcha(){
                var _this = this;
                axios.get('${apiPath}/sms/send',{
                    params:{
                        phoneNumber:_this.phoneNumber,
                    }
                }).then(function(res){            
                    if (res.data.code==1){
                        console.log(res.data.message);
                        _this.authenticCode = res.data.result;
                        _this.countdown=60;
                        _this.settime();
                    }
                }).catch(function(err){
                    alert('获取验证码失败: '+err.message+" 请重试！");
                })
                
            },
            confirm(){
                var _this = this;
                axios.get('${apiPath}/member/bindPhoneNum',{
                    params:{
                        phoneNumber:_this.phoneNumber,
                        code:_this.captchaNumber,
                    }
                }).then(function(res){  
                    window.location.href = ${redirectUrl};
                }).catch(function(err){
                    alert('验证失败: '+err.message+" 请重试！");
                })
            },
            settime(){
                if (this.countdown == 0) {
                    if (this.checkPhoneNumber){
                        this.$refs.getCaptcha.removeAttribute("disabled")
                    }
                    this.$refs.getCaptcha.innerHTML="获取验证码"
                    this.countdown = 60
                } else {
                    this.$refs.getCaptcha.setAttribute("disabled", "")
                    this.$refs.getCaptcha.innerHTML=this.countdown+"s后重新获取"
                    this.countdown --
                    var _this= this
                    setTimeout(function() {
                        _this.settime()
                    },1000)
                }
            }
        }
    })
</script>

<style>
    body{
        background-color: #f4f4f4;
        padding:1rem;
    }
    h2{
        padding:1rem 0rem;
    }
    .main-tip{
        color:black;
        font-size:1rem;
        font-weight: 400;
        margin:0.3rem 0rem;
    }
    #captchaBox{
        border-bottom: 1px solid #EDEDED;
    }
    #phoneNumber{
        width:calc(98% - 1rem);
    }
    #phoneNumber{
        border:none;
        border-bottom: 1px solid #EDEDED;
        height:2rem;
        width:100%;
        outline:none;
        background-color: #f4f4f4;
        font-size:2rem;
    } 
    #captcha{
        border:none;
        outline:none;
        height:2rem;
        font-size:2rem;
        width:calc(98% - 8rem);
        background-color: #f4f4f4;
    }
    #phoneNumber::-webkit-input-placeholder, #captcha::-webkit-input-placeholder{
        font-size:1rem;
        color:#999999;
    }
    .sub-tip{
        color:#999999;
        font-size:0.9rem;
        padding-top:0.6rem;
        padding-bottom:0.8rem;
    }
    .sub-tip-always{
        color:#A05A28;
        font-size:0.9rem;
        padding-top:0.3rem;
        padding-bottom:0.8rem;
    }
    #getCaptcha{
        color:#999999;
        background-color: #f4f4f4;
        outline: none;
        width:8rem;
        height:1rem;
        border:none;
        border-left:2px solid #ddd;
        margin:1rem 0rem;
    }
    #confirm{
        margin:2rem 0.5rem 0rem 0.5rem;
        font-size:1.6rem;
        font-weight:800;
        color:white;
        background-color: #A05A28;
        opacity: 0.5;
        border-radius: 20px;
        border:none;
        outline: none;
        width:calc(100% - 1rem);
        height:3rem;
    }
</style>