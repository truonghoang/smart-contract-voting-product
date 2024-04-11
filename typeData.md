smart contract{

 // fixed-sỉz types
# boolean isEnabled // true or false
# uint a   // 1,2,3
# address sender // 0xf90....
 bytes32 data // chứa byte có độ lớn 32 byte
 // variable-size types
 # string name ; // name
# bytes data ;
 # unit[] amount; // array [1,4,7,6] phải cùng kiểu dữ liệu
 # mapping(address --> bool) whitelist; // 0x45fsdg... =>true
// user define
# struct User {
    uint id
    string name;
    bool isFriend;
 } // user.name
 # enum color {
    red,green,blue
 } //color.red

 //built in // có sẵn trong solidity

 msg.send // địa chỉ người gửi
 msg.value // giá trị của hàm

}

# --------------------------------------

 # chú ý về gas private  mỗi block chỉ có giới hạn gas private
 -  hạn chế sử dụng vòng lặp ( tốn gas) nếu block hàm có block vượt gas private thì hàm sẽ không được xử lí
 
 # storage array
  // storage array : luu trên blockchain tốn gas khi thực thi


uint[] array // crud

- khi dùng delete phần tử array sẽ không xóa khỏi mảng mà sẽ reset phần tử về giá trị mặc định của kiểu của mảng

  // memory array : lưu trong bộ nhớ sẽ k tốn gas
uint[] memory newArr = new uint[](10)

#  // array as parameter: khai báo trong function
function f(uint[] calldata arr) external {
    nếu external thì phải gọi calldata
    nếu public hay internal thì dùng memory
}

# mapping : biết được key sẽ truy cập được vào value

vd : mapping(address => uint) balances; 

- nếu KeyNotExist sẽ trả về giá trị mặc định của kiểu dữ liệu khai báo

// nested mapping : gọi mapping trong mapping
vd: mapping(address=>mapping(address=>bool)) approved ;
cách truyền: vd: approved[msg.sender][spender]

# struct : lưu trữ dữ liệu có cấu trúc liên quan

vd : struct player {
    uint ID;
    address addre;
    string name;
}

player memory player1 = player(1,msg.sender,_name);

# event : smart contract đẩy ra cho bên thứ 3 có thể bắt để catch event

 event deposit (address from , uint amount)

 function deposit(uint amount) external {
    emit deposit(msg.sender,uint amount);
 }

event deposit (address indexed from , uint amount) : lọc theo địa chỉ người đã gửi
 
 # handle error end modifier 

 throw, assert, resert
 // hay dùng require
*** nếu nhiều require thì dùng modifiers ***
modifier CheckA(){
    require(a==b, "error");
    _ // gọi đến hàm thực thi
}

function foo() public CheckA {}

# tính thừa hưởng trong solidity (inheritance)

- kế thừa smart contract
import "./B.sol"
 vd contract A is B {

 }
 # giao tiếp giữa smart contract