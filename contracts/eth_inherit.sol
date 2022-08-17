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
    
    enum Roles{ ADMIN, PARENT, CHILD }

    constructor()  {
        admin = msg.sender;
    }

    struct Parent {
        address payable _address;
        string name;
        string surname;
        // sonradan mapping yapabiliriz
        address[] childrenAddresses;
        bool isValue;
        Roles role;
    }

    struct Child {
        address payable _address;
        string name;
        string surname;
        // releasetime veya birthdate
        uint256 releaseTime;
        uint256 balance;
        address parentAddress;
        bool isValue;
        Roles role;
    }

    mapping (address => Parent) private parents;
    mapping (address => Child) private children;
    address[] private parentsArray;

    // herkes çağırabilir
    function addParent(address payable _address, string memory name, string memory surname) public {
        require(getRole(msg.sender) != Roles.CHILD && getRole(msg.sender) != Roles.PARENT);
        Parent storage parentObject = parents[_address]; 
        require(!(parents[_address].isValue), "Parent already in system.");
        parentObject._address = _address;
        parentObject.name = name;
        parentObject.surname = surname;
        parentObject.isValue = true;
        parentObject.role = Roles.PARENT;
        parentsArray.push(_address);
    }

    function addChild(address payable childAddress, string memory name, string memory surname) public {
        // releaseTime ve balance başka metotta
        // sadece parent yapabilir
        require(getRole(msg.sender) == Roles.PARENT, "You are not a parent.");
        
        // metodu çağıran ebeveynin adresini al
        address parentAddress = msg.sender;
        // EKLE: burayı düzelt çok kötü (modifier mıdır event midir ona çevir)
        // metodu çağıran ebeveyn sistemde var mı?
        // Parent storage parentObject = parents[parentAddress];
        require(parents[parentAddress].isValue, "Parent not in system.");

        // eklenecek çocuk sistemde var mı?        
        require(!(children[childAddress].isValue), "Child already in system.");

        Child storage childObject = children[childAddress];
        childObject._address = childAddress;
        childObject.name = name;
        childObject.surname = surname;
        childObject.parentAddress = parentAddress;
        childObject.isValue = true;
        childObject.role = Roles.CHILD;
        parents[parentAddress].childrenAddresses.push(childAddress);
    }

    function getParent() public view returns(Parent memory result) {
        if(getRole(msg.sender) == Roles.PARENT) {
            result = parents[msg.sender];
        } else {
            result = parents[children[msg.sender].parentAddress] ;
        }
    }

    function getAllParents() public view returns(address[] memory result) {
        // Sadece admin icin, butun parentlari doner
        require(getRole(msg.sender) == Roles.ADMIN, "You are not an admin.");
        result = parentsArray;
    }
    
    function getChild() public view returns(Child memory result) {
        // EKLE: çocuk sadece kendi bilgilerini görebilmeli parent ve admin bütün çocukların bilgilerini görebilmeli
        Child storage child = children[msg.sender]; 
        result = child;
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

    function getRole(address roleAddress) public view returns(Roles _type) {
        if (parents[roleAddress].isValue) {
            _type = Roles.PARENT;
        }
        else if (children[roleAddress].isValue) {
            _type = Roles.CHILD;
        }
        else if (roleAddress == admin) {
            _type = Roles.ADMIN;
        }
    }
    
    /*
    function isWalletinThere (address askedAddress,address[] childrenAddresses,address payable _address){
        mapping(address =>bool) public _Addresses;

        
    } 
    */
    
    // smart contracttan para çekme metodu/metotları

    function withdrawMoney(uint amount) public {
        address personAddress = payable(msg.sender);
        Roles role = getRole(personAddress); 

        // parent için 
        if(role == Roles.PARENT) {
            (bool sent, bytes memory data) = personAddress.call{value: amount}("");
            require(sent, "Failed to send Ether");
        }

        // çocuk için
        else if(role == Roles.CHILD) {
            // EKLE: releaseTime'a bakacak, tarih geçmişse izin verecek, geçmemişse hata
            // balance değerini gönderecek
            // !! mapping'i güncelleyecek, çocuğu silecek
        }
    }

    // EKLE: çocuğun miktarı düzenleme metodu

}
