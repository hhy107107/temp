axios.defaults.baseURL = 'http://192.168.0.129:8060/lovecoffee';

// Vue.prototype.authorize = function (){
//     axios.get('/wechat/authorize2',{
//         params:{}
//     }).then(function(res){ 
//     	console.log(res.data);           
//         return (res.data);
//     }).catch(function(err){
//         alert('身份认证失败: '+err.message);
//     })
// }