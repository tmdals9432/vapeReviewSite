package com.vape.dto;

public class Product {
    private String id;       // 제품 ID (1, 2, 3...)
    private String name;     // 제품명 (릴 하이브리드 등)
    private String price;    // 가격
    private String desc;     // 설명
    private String type;     // 대분류 (heat, liquid, disposable)
    private String sub;      // 소분류 (device, stick, mtl, dtl)
    private String filename; // 이미지 파일명 (나중에 이미지 넣을 때 필요)

    public Product(String id, String name, String price, String desc, String type, String sub, String filename) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.desc = desc;
        this.type = type;
        this.sub = sub;
        this.filename = filename;
    }

    // Getter들
    public String getId() { return id; }
    public String getName() { return name; }
    public String getPrice() { return price; }
    public String getDesc() { return desc; }
    public String getType() { return type; }
    public String getSub() { return sub; }
    public String getFilename() { return filename; }
}