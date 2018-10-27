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
    <link rel="stylesheet" href="${staticPath}/css/swiper.min.css">
    <script type="text/javascript" src="${staticPath}/js/vue.js"></script>
    <script type="text/javascript" src="${staticPath}/js/weui.js"></script>
    <script type="text/javascript" src="${staticPath}/js/swiper.min.js"></script>
    <script type="text/javascript" src="${staticPath}/js/vue-awesome-swiper.js"></script>
    <script type="text/javascript" src="${staticPath}/js/vue-lazyload.js"></script>
    <script type="text/javascript" src="${staticPath}/js/vue-cookies.js"></script>
    <script type="text/javascript" src="${staticPath}/js/axios.js"></script>
    <script type="text/javascript" src="${staticPath}/js/server.js"></script>
</head>
<body>
	<div id="app">
		<swiper  :options="swiperOption">
            <!-- slides -->
            <swiper-slide v-for="item in banners">
                <a :href="item.clickHyperlink">
                    <img class="banner-image" v-lazy="item.bannerImg"></img>
                </a>
            </swiper-slide>
            <!-- Optional controls -->
            <!-- <div class="swiper-button-prev" slot="button-prev"></div>
            <div class="swiper-button-next" slot="button-next"></div> -->
        </swiper>
        <div class="swiper-pagination"  slot="pagination"></div>
        <div class="category-box">
            <div class="category-item-box" v-for="(item,index) in categories" @click="pullItems(item.id,index)">
                <image class="category-image" v-lazy="item.categoryImg"></image>
                <p v-bind:class="{selected:index==selectedIndex}">{{item.categoryName}}</p>
            </div>
        </div>
        <div class="middle-box">
            <p>咖啡GO</p>
            <p>海量甄选咖啡，随心购</p>
        </div>
        <div class="float-left">
            <div class="item-box" v-for="(item, index) in items" v-if="!(index%2)">
                <a :href="jumpItem(item.id)">
                    <img  class="item-image" v-lazy="item.goodsImg"></img>
                    <p>{{item.goodsName}}</p>
                    <p>{{item.goodsDesc}}</p>
                    <p>¥<span>{{item.goodsPrice}}</span></p>
                    <img  class="recommended" :src="recommendedLogo" v-if="item.hot"/>
                </a>
            </div>
        </div>
        <div class="float-right">
            <div class="item-box" v-for="(item, index) in items" v-if="index%2">
                <a :href="jumpItem(item.id)">
                    <img  class="item-image" v-lazy="item.goodsImg"></img>
                    <p>{{item.goodsName}}</p>
                    <p>{{item.goodsDesc}}</p>
                    <p>¥<span>{{item.goodsPrice}}</span></p>
                    <img  class="recommended" :src="recommendedLogo" v-if="item.hot"/>
                </a>
            </div>
        </div>
        <div class="empty-box" v-show="items.length==0">
            <img src="${staticPath}/images/member/占位图@3x.png">
            <p>亲，暂无商品哦～</p>
        </div>
        <div class="tip-box">
            <span>———————— 小小幸福 在你身边 ————————</span>
        </div>
        <img id="scrollTop" src="${staticPath}/images/index/返回顶部icon@3x.png" v-show="flagScrollTop" v-on:click="backTop"></img>
	</div>
</body>
</html>

<script>
    Vue.use(VueAwesomeSwiper)
    Vue.use(VueLazyload, {
      preLoad: 1.3,
      error: '${staticPath}/images/index/商品详情主图占位图@3x.png',
      loading: '${staticPath}/images/index/商品详情主图占位图@3x.png',
      attempt: 3
    })

	var app = new Vue({
        el: '#app',
        data(){
            return{
            	msg:"helloworld!",
                recommendedLogo:'${staticPath}/images/index/热卖icon@3x.png',
                flagScrollTop:false,
                selectedIndex:0,
                swiperOption: {
                    slidesPerView: 1,
                    pagination: {
                        el: '.swiper-pagination',
                        clickable: true
                    }
                },
                banners:[
                ],
                categories:[
                ],
                items:[
                ]
            }
        },
        created(){
            this.checkScrollTop()  
        },
        async mounted(){
            this.pullBanners();
            await this.pullCategories();
            this.pullItems(this.categories[0].id,0);
        },
        components: {
            LocalSwiper: VueAwesomeSwiper.swiper,
            LocalSlide: VueAwesomeSwiper.swiperSlide,
        },
        methods: {
            pullBanners(){
                var _this = this;
                axios.get('${apiPath}/home/bannerList',{
                    params:{}
                }).then(function(res){            
                    if (res.data.code==1){
                        console.log(res.data.message);
                        _this.banners = res.data.result;
                    }
                }).catch(function(err){
                    alert('拉取轮播图失败: '+err.message);
                })
            },
            async pullCategories(){
                var _this = this;
                await axios.get('${apiPath}/goods/categoryList',{
                    params:{}
                }).then(function(res){            
                    if (res.data.code==1){
                        console.log(res.data.message);
                        _this.categories = res.data.result;
                        _this.selectedIndex = 0;
                    }
                }).catch(function(err){
                    alert('拉取分类列表失败: '+err.message);
                });
            },
            pullItems(id,index){
                this.selectedIndex = index;
                var _this = this;
                axios.get('${apiPath}/goods/list',{
                    params:{
                        categoryId:id,
                        pageNo:1,
                        pageSize:100,
                    }
                }).then(function(res){            
                    if (res.data.code==1){
                        console.log(res.data.message);
                        _this.items = res.data.result.list;
                    }
                }).catch(function(err){
                    alert('拉取分类列表失败: '+err.message);
                })
            },
            checkScrollTop(){
                var _this = this
                window.onscroll = function () {
                    let osTop = document.documentElement.scrollTop || document.body.scrollTop
                    if (osTop >= 300) {
                        _this.flagScrollTop = true
                    } else {
                        _this.flagScrollTop = false
                    }
                }
            },
            backTop(){
                document.documentElement.scrollTop = document.body.scrollTop =0
            },
            jumpItem(id){
                return "${apiPath}/view/detail?goodsId="+id;
            }
        }
    })
</script>

<style type="text/css">
    body{
        background-color: #F4F4F4;
        overflow-x: hidden;
    }
    .swiper-container {
        height: 12rem;
        margin:1rem;
        width:calc(100% - 2rem);
        overflow: hidden;
    }
    .swiper-pagination-bullet{
        border-radius:3px;
        background-color: #2F2F2F;
        width:1rem;
        height:0.3rem;
        margin:0rem 0.3rem;
    }
    .swiper-pagination{
        position:relative;
        top:-1.2rem;
    }
    .swiper-slide {
        text-align: center;
        font-size: 38px;
        font-weight: 700;
        background-color: #eee;
        display: -webkit-box;
        display: -ms-flexbox;
        display: flex;
        -webkit-box-pack: center;
        -ms-flex-pack: center;
        justify-content: center;
        -webkit-box-align: center;
        -ms-flex-align: center;
        align-items: center;
    }
    .banner-image{
        width:100%;
        height:100%;
    }
    .category-item-box{
        width:25%;
        height:8rem;
        display: inline-block;
        text-align: center;
    }
    .category-image{
        width:5rem;
        height:5rem;
        border-radius:50%;
    }
    .selected{
        font-weight: 800;
        color:rgb(160,90,40);
    }
    .middle-box{
        height:3rem;
        width:calc(100% - 1rem);
        padding-left:1rem;
    }
    .middle-box p:first-child{
        font-weight:900;
        font-size:1.3rem;
    }
    .middle-box p:last-child{
        color:#999999;
        font-size:1rem;
    }
    .float-left, .float-right{
        width:49%;
        display: inline-block;
        vertical-align: top;
    }
    .item-box{
        height:auto;
        width:calc(100% - 1.6rem);
        margin:0.8rem;
        border-radius:8px;
        display: inline-block;
        background-color: white;
        overflow: hidden;
        vertical-align: top;
    }
    .item-box img:first-child{
        width:100%;
        height:auto;
    }
    .item-box p:nth-child(2){
        color:black;
        font-size:1rem;
        padding:0rem 0.5rem;
        word-wrap : break-word ;
    }
    .item-box p:nth-child(3){
        color:#999999;
        font-size:1rem;
        padding:0rem 0.5rem;
        word-wrap : break-word ;
    }
    .item-box p:nth-child(4){
        color:#B25020;
        padding:0rem 0.5rem;
        display: inline-block;
    }
    .item-box p:nth-child(4) span{
        font-size:1.5rem;
    }
    .item-box img:nth-child(5){
        float:right;
        max-height:2rem;
        margin-right:0.8rem;
        margin-bottom:0.3rem;
    }
    .tip-box{
        text-align:center;
        height:3rem;
        color:#999999;
        font-size:0.8rem;
    }
    #scrollTop{
        position:fixed;
        bottom:2rem;
        right:1.2rem;
        max-height: 2.5rem;
        z-index:999;
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
</style>