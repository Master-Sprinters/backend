// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

/* modifier
event
tarih veritipi nasıl tutulur
openzeppelin 

testleri typescript ile yaz */

// SOR: kullanıcı site dışında kontratla iletişime geçemez mi?? (remixle mesela)

contract Eth_Inherit {

    address private admin; 

    constructor()  {
        admin = msg.sender;
    }

    struct Parent {
        address payable _address;
        string name;
        string surname;
        // sonradan mapping yapabiliriz
        address[] childrenAddresses;
    }

    struct Child {
        address payable _address;
        string name;
        string surname;
        // releasetime veya birthdate
        uint256 releaseTime;
        uint256 balance;
        address parentAddress;
    }

    mapping (address => Parent) private parents;
    mapping (address => Child) private children;

    // herkes çağırabilir
    function addParent(address payable _address, string memory name, string memory surname) public {
        Parent storage parentObject = parents[_address]; 
        require((parentObject._address == address(0)), "Parent already in system.");
        parentObject._address = _address;
        parentObject.name = name;
        parentObject.surname = surname;
    }

    function getParent() public view returns(Parent memory result) {
        // EKLE: eğer adminse herkesinkini görmeli, değilse sadece kendininkini
        Parent storage parent = parents[msg.sender]; 
        result = parent;
    }
    function getChild() public view returns (Child memory result){
        //EKLE: çocuk sadece kendi bilgilerini görebilmeli parent ve admin bütün çocukların bilgilerini görebilmeli
        Child storage child = children[msg.sender]; 
        result = child;
    }

    function addChild(address payable childAddress, string memory name, string memory surname) public {
        // releaseTime ve balance başka metotta
        // sadece parent yapabilir
        
        // metodu çağıran ebeveynin adresini al
        address parentAddress = msg.sender;
        
        // EKLE: burayı düzelt çok kötü (modifier mıdır event midir ona çevir)
        // metodu çağıran ebeveyn sistemde var mı?
        Parent storage parentObject = parents[parentAddress];
        require((parentObject._address != address(0)), "Parent not in system.");
        
        // eklenecek çocuk sistemde var mı?
        Child storage childObject = children[childAddress];
        require((childObject._address == address(0)), "Child already in system.");
        
        childObject._address = childAddress;
        childObject.name = name;
        childObject.surname = surname;

        childObject.parentAddress = parentAddress;
        // EKLE: childrenAddress'e çocuk adresi eklemesi
    }

    // smart contracta para yollama metodu
    function sendMoneytoContract(address childAddress, uint256 releaseTime, uint256 amount) public payable {
        address owner = msg.sender;
        Child storage _child = children[childAddress];
        _child.releaseTime = releaseTime;
        _child.balance= amount;
        
        /* 
            EKLE: 
            çocuk sistemde var mı?
            releaseTime kontrolü (tarih ileri bir tarih mi?)
            gönderilen para yeterli mi? 
        */

    }

    /*function getRoles (address roleAddress) public view returns(string){

    }
    function isWalletinThere (address askedAddress,address[] childrenAddresses,address payable _address){
        mapping(address =>bool) public _Addresses;

        
    }*/
    // smart contracttan para çekme metodu/metotları

}
