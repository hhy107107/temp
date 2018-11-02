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
    <script type="text/javascript" src="${staticPath}/js/vue-cookies.js"></script>
    <script type="text/javascript" src="${staticPath}/js/axios.js"></script>
    <script type="text/javascript" src="${staticPath}/js/server.js"></script>
    <script type="text/javascript" src="${staticPath}/js/date.js"></script>
</head>
<body>
	<div id="app">
		<div class="card">
            <div class="profile">
                <img :src="user.profile"/>
            </div>
            <div class="info">
                <span>{{user.name}}</span>
                <br/>
                <span>账户余额： ¥ <span>{{user.balance}}</span></span>
                <br/>
                <span>余额仅限企业用户可充值使用</span>
            </div>
        </div>
        <div class="middle-box">
            <p>余额明细</p>
        </div>
        <div class="item" v-for="item in items">
            <div class="left-box">
                <p>
                    <span v-if="item.rechargeAmount>=0">充值</span>
                    <span v-else>消费</span>
                </p>
                <p>{{format(item.createTime)}}</p>
            </div>
            <div class="right-box">
                <p>{{item.rechargeAmount}}</p>
            </div>
        </div>
        <div class="reminder"></div>
        <div class="empty-box" v-show="items.length==0">
            <img src="${staticPath}/images/member/占位图@3x.png">
            <p>亲，暂无余额明细哦～</p>
        </div>
        <div class="bottom-navi">
            <a href="${apiPath}/view/index.html">咖啡</a><a href="${apiPath}/view/orderDetails.html">订单</a><a href="${apiPath}/view/memberDetail.html">个人账户</a>
        </div> 
	</div>
</body>
</html>

<script>
	var app = new Vue({
        el: '#app',
        data(){
            return{
            	msg:"helloworld!",
                user:{
                    // name:'Francie',
                    // profile:'${staticPath}/images/coffee.png',
                    // balance:100.10,
                },
                items:[
                    // {
                    //     //type: '余额消费',
                    //     createTime:1540432913000,
                    //     rechargeAmount: 100,
                    // },
                    // {
                    //     //type: '企业充值',
                    //     createTime:1540432913000,
                    //     rechargeAmount: 20,
                    // },
                    // {
                    //     //type: '余额消费',
                    //     createTime:1540432913000,
                    //     rechargeAmount: -10,
                    // }
                ]
            }
        },
        // created(){
        //     var user = this.$cookies.get('user')
        //     if (!user){
        //         //window.location.href = "bindingMobilePhone.ftl"
        //     }
        // }
        mounted(){
            this.pullUserInfo();
            this.pullRecords();
        },
        methods:{
            format(time) {
                return new Date(time).Format('yyyy年MM月dd日 hh:mm:ss');
            }, 
            pullUserInfo(){
                var _this = this;
                axios.get('${apiPath}/member/getUserInfo',{
                    params:{
                    }
                }).then(function(res){            
                    if (res.data.code==1){
                        _this.user.name=res.data.result.nickname;
                        _this.user.profile = res.data.result.avatar;
                        _this.user.balance = res.data.result.balance;
                    }else{
                        alert ('获取用户信息失败: '+res.data.message);
                    }
                }).catch(function(err){
                    alert('获取用户信息失败: '+err.message);
                })
            },
            pullRecords(){
                var _this = this;
                axios.get('${apiPath}/member/getUserBalanceRecord',{
                    params:{
                        pageNo:1,
                        pageSize:10000,
                    }
                }).then(function(res){            
                    if (res.data.code==1){
                        _this.items=res.data.result.list;
                    }else{
                        alert ('获取用户记录失败: '+res.data.message);
                    }
                }).catch(function(err){
                    alert('获取用户记录失败: '+err.message);
                })
            }
        }
    })
</script>

<style type="text/css">
    body{
        overflow-x: hidden;
        background-color: #f4f4f4;
    }
    .card{
        background-image: url('${staticPath}/images/member/卡片背景@3x.png');
        background-size: contain;
        background-repeat: no-repeat;
        margin:0.8rem;
        width:calc(100% - 1.6rem);
        height:10rem;
    }
    .profile{
        display: inline-flex;
        justify-content: center;
        align-items: center;
        vertical-align: top;
        height:10rem;
        width:30%;
    }
    .profile img{
        width:5rem;
        height:5rem;
        border-radius:50%;
    }
    .info{
        display: inline-block;
        width:68%;
        padding-top:1rem;
    }
    .info span:nth-child(1), .info span:nth-child(3){
        color:white;
        font-size:1.2rem;
        font-weight:800;
    }
    .info span:nth-child(3) span{
        font-size:1.8rem;
    }
    .info span:nth-child(5){
        color:white;
        font-size:0.9rem;
        font-weight:500;
    }
    .middle-box{
        height:2rem;
        width:calc(95% - 4rem);
        padding-left:1.8rem;
    }
    .middle-box p:first-child{
        font-weight:900;
        font-size:1.3rem;
    }
    .item{
        margin:0.5rem 1.8rem;
        border-bottom:1px solid #E5E5E5;
    }
    .left-box{
        display: inline-block;
        width:68%;
    }
    .left-box p:first-child{
        color:black;
        font-weight:800;
    }
    .left-box p:last-child{
        color:#999999;
        font-size:1rem;
    }
    .right-box{
        display: inline-flex;
        justify-content: flex-end;
        align-items: center;
        vertical-align: top;
        width:30%;
        height:100%;
    }
    .right-box p{
        font-weight:800;
        line-height:3rem;
    }
    .empty-box{
        height:30rem;
        text-align:center;
    }
    .empty-box img{
        width:10rem;
        margin-top:5rem;
    }
    .empty-box p{
        color:#666666;
        font-size:1rem;
        margin-top:3rem;
    }
    .reminder{
        width:100%;
        height:3rem;
        display: inline-block;
    }
    .bottom-navi{
        height:3rem;
        position:fixed;
        width:100%;
        bottom: 0rem;
        background-color: rgb(250,250,250);
    }
    .bottom-navi a{
        width:32.7%;
        border:1px solid rgb(231,231,231);
        color:rgb(93,93,93);
        line-height: 3rem;
        text-align: center;
        text-decoration: none;
        display: inline-block;
    }
</style>