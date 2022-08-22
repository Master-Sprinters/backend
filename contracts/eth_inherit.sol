// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

/* modifier
event
openzeppelin 
*/

contract Eth_Inherit {

    address private admin; 

    enum Roles{ ADMIN, PARENT, CHILD, UNREGISTERED }

    constructor()  {
        admin = msg.sender;
    }

    struct Parent {
        address payable _address;
        string name;
        string surname;
        // ebeveynin çocuklarının tutulduğu array
        address[] childrenAddresses;
    }

    struct Child {
        address payable _address;
        string name;
        string surname;
        // releaseDate veya birthdate
        uint256 releaseDate;
        uint256 balance;
        address parentAddress;
    }

    mapping (address => Parent) private parents;
    mapping (address => Child) private children;
    address[] private parentsArray;

    function addParent(address payable _address, string memory name, string memory surname) public {
        require(getRole(msg.sender) != Roles.CHILD && getRole(msg.sender) != Roles.PARENT);
        
        Parent storage parentObject = parents[_address]; 
        require((parents[_address]._address == address(0)), "Parent already in system.");
        parentObject._address = _address;
        parentObject.name = name;
        parentObject.surname = surname;
        parentsArray.push(_address);
    }

    function addChild(address payable childAddress, string memory name, string memory surname, uint256 releaseDate) public payable {

        // sadece parent yapabilir
        require(getRole(msg.sender) == Roles.PARENT, "You are not a parent.");
        
        // metodu çağıran ebeveynin adresini al
        address parentAddress = msg.sender;

        // metodu çağıran ebeveyn sistemde var mı?
        require(parents[parentAddress]._address != address(0), "Parent not in system.");

        // eklenecek çocuk sistemde var mı?        
        require((children[childAddress]._address == address(0)), "Child already in system.");

        Child storage childObject = children[childAddress];
        // ters mantık (tuhaf)
        require(!dateCheck(childObject.releaseDate));
        childObject._address = childAddress;
        childObject.name = name;
        childObject.surname = surname;
        childObject.parentAddress = parentAddress;
        childObject.releaseDate = releaseDate;
        childObject.balance= msg.value;
        parents[parentAddress].childrenAddresses.push(childAddress);
    }

    function getParent() public view returns(Parent memory result) {
        if(getRole(msg.sender) == Roles.PARENT) {
            result = parents[msg.sender];
        } else {
            result = parents[children[msg.sender].parentAddress] ;
        }
    }

    function getAllParents() public view returns(Parent[] memory result) {
        // Sadece admin icin, butun parentlari doner
        require(getRole(msg.sender) == Roles.ADMIN, "You are not an admin.");
        result = new Parent[](parentsArray.length); 
        for (uint i = 0; i < parentsArray.length; i++) {
            result[i] = parents[parentsArray[i]];
        }
    }

    function getChildren(address parentAddress) public view returns(Child[] memory result) {
        // Sadece admin icin, bir parent'ın bütün çocuklarını döner
        require(getRole(msg.sender) == Roles.ADMIN, "You are not an admin.");

        address[] memory childrenAddressArray = parents[parentAddress].childrenAddresses;
        result = new Child[](childrenAddressArray.length); 
        for (uint i = 0; i < childrenAddressArray.length; i++) {
            result[i] = children[childrenAddressArray[i]];
        }
    }

    // kontrattaki toplam parayı gösterir
    function seeContractBalance() public view returns(uint contractBalance) {
        require(getRole(msg.sender) == Roles.ADMIN, "You are not an admin.");
        contractBalance = address(this).balance;
    }

    function getChildrenAsParent() public view returns(Child[] memory result) {
        // Sadece parent için, kendi çocuklarından oluşan bir array döner
        require(getRole(msg.sender) == Roles.PARENT, "You are not a parent.");
        Parent memory parentObject = parents[msg.sender];
        result = new Child[](parentObject.childrenAddresses.length);
        for (uint i = 0; i < parentObject.childrenAddresses.length; i++) {
            result[i] = children[parentObject.childrenAddresses[i]];
        }
    }

    function getChild() public view returns(Child memory result) {
        require(getRole(msg.sender) == Roles.CHILD, "You are not a child.");
        Child storage child = children[msg.sender]; 
        result = child;
    }

    // çocuk sonradan parent olursa aşağıdaki sıraya göre ZATEN ilk olarak parent dönecektir !
    function getRole(address roleAddress) public view returns(Roles) {
        if (roleAddress == admin) {
            return(Roles.ADMIN);
        }
        else if (parents[roleAddress]._address != address(0)) {
            return(Roles.PARENT);
        }
        else if (children[roleAddress]._address != address(0)) {
            return(Roles.CHILD);
        }
        else {
            return(Roles.UNREGISTERED);
        }
    }
    
    // smart contracttan para çekme metotları

    function childWithdraw() public {
        address personAddress = payable(msg.sender);
        require(getRole(personAddress) == Roles.CHILD, "User not a child.");
        Child storage childObject = children[personAddress];
        
        if(dateCheck(childObject.releaseDate)){
            (bool sent, bytes memory data) = personAddress.call{value: childObject.balance}("");
            require(sent, "Failed to send Ether");
            
            deleteChild(personAddress);
        }
    }
    
    function editChildInfo(address childAddress) public payable {
        // EKLE: balance'da çıkarma veya ekleme hesabını bizim yapmamız lazım (msg.value kullanabilmek için)
        // tarih değiştirme (ileri bir tarih olmalı)
        // sadece parent yapabilir
        // parent'ın çektiği paranın balance'dan daha büyük olmaması lazım
        // parentWithdraw() çağır
    }

    function parentWithdraw(uint amount) private {
        // çocuktaki çektiği para yeterli olmalı
        address personAddress = payable(msg.sender);
        require(getRole(personAddress) == Roles.PARENT, "User not a parent.");
        
        (bool sent, bytes memory data) = personAddress.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }

    // bir çocuğu sistemden siler VE parayı ebeveyne geri gönderir.
    // SOR: güvenlik iyi mi bunda??
    function cancelChild(address childAddress) public {
        address personAddress = payable(msg.sender);
        // metodu çağıran kişi silmek istediği çocuğun ebeveyni olmalı 
        require(personAddress == children[childAddress].parentAddress);

        (bool sent, bytes memory data) = personAddress.call{value: children[childAddress].balance}("");
        require(sent, "Failed to send Ether");

        deleteChild(childAddress);
    }

    // bir çocuğu sistemden siler. 
    function deleteChild(address childAddress) private {
        // childrenAddresses'den çocuğu silme
        Child memory childObject = children[childAddress];
        address _parentAddress = childObject.parentAddress;
        for (uint i = 0; i < parents[_parentAddress].childrenAddresses.length; i++) {
            if (parents[_parentAddress].childrenAddresses[i] == childAddress) {
                delete parents[_parentAddress].childrenAddresses[i];
            }
        }
            
        // tamamen silme
        delete children[childAddress];
    }

    function dateCheck(uint releaseDate) private view returns(bool) {
        return (block.timestamp > releaseDate);
    }
}
