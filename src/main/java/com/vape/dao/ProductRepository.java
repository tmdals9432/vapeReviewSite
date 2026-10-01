package com.vape.dao;

import java.util.ArrayList;
import java.util.List;
import com.vape.dto.Product;
import java.util.Collections;
import java.util.Comparator;
import com.vape.dao.ReviewRepository;

public class ProductRepository {
    private static List<Product> products = new ArrayList<>();

    // ★ 여기에 실제 데이터를 마음껏 추가하세요!
    static {
        // (ID, 이름, 가격, 설명, 대분류, 소분류, 이미지파일명)
        
        // 1. 궐련형 기기
        products.add(new Product("1", "릴 하이브리드 3.0", "88,000", "3가지 모드로 즐기는 청소 없는 편리함", "heat", "device", "lil.jpg"));
        products.add(new Product("2", "아이코스 일루마", "99,000", "스마트코어 인덕션 시스템 적용", "heat", "device", "iqos.jpg"));
        products.add(new Product("3", "QOQ 아너 맥스", "58,000", "메탈 바디의 묵직함. 30개비 연속 사용이 가능한 넉넉한 배터리.", "heat", "device", "qoq_honor.jpg"));
        products.add(new Product("4", "릴 하이브리드 2.0", "68,000", "여전히 현역인 명기. 3.0보다 저렴하지만 핵심 기능은 모두 갖추고 있습니다.", "heat", "device", "lil_hybrid_2.jpg"));
        
        // 1-1 궐련형 스틱 
        products.add(new Product("5", "믹스(MIIX) 믹스", "4,500", "부드러운 맛과 시원한 맛의 조화", "heat", "stick", "mix.jpg"));
        products.add(new Product("6", "믹스(MIIX) 아이스 모아", "4,500", "두 번 터지는 캡슐의 시원함. 릴 하이브리드 사용자들의 최애 멘솔 스틱.", "heat", "stick", "miix_ice_moa.jpg"));
        products.add(new Product("7", "믹스(MIIX) 업투", "4,500", "독특한 폴라 캡슐의 향긋함. 커피와 잘 어울리는 부드러운 맛.", "heat", "stick", "miix_upto.jpg"));
        products.add(new Product("8", "핏(Fiit) 체인지", "4,500", "캡슐을 터뜨리면 상쾌한 맛으로 변하는 릴 솔리드 전용 베스트셀러.", "heat", "stick", "fiit_change.jpg"));
        products.add(new Product("9", "핏(Fiit) 체인지 업", "4,500", "과일 향 캡슐의 달콤함. 호불호 없이 누구나 좋아하는 대중적인 맛.", "heat", "stick", "fiit_change_up.jpg"));
        products.add(new Product("10", "테리아(TEREA) 앰버", "4,800", "구운 곡물의 고소한 풍미. 아이코스 일루마 전용의 묵직한 연초 맛.", "heat", "stick", "terea_amber.jpg"));
        products.add(new Product("11", "테리아(TEREA) 실버", "4,800", "가장 부드럽고 깔끔한 연초 맛. 자극적이지 않아 데일리로 피우기 좋습니다.", "heat", "stick", "terea_silver.jpg"));
        products.add(new Product("12", "테리아(TEREA) 그린", "4,800", "은은하고 부드러운 멘솔. 과하지 않은 시원함을 선호하는 분들에게 적합.", "heat", "stick", "terea_green.jpg"));
        products.add(new Product("13", "메비우스 스무스 레귤러", "4,800", "목 넘김이 부드럽고 깔끔한 연초 맛. 자극적이지 않은 맛을 선호하는 분께 추천.", "heat", "stick", "mevius_smooth.jpg"));
        products.add(new Product("14", "메비우스 샤프 콜드", "4,800", "뼛속까지 시원해지는 강력한 멘솔. 잡맛 없이 깔끔한 쿨링감이 일품.", "heat", "stick", "mevius_sharp_cold.jpg"));
        products.add(new Product("15", "네오(Neo) 프레쉬", "4,800", "이름처럼 상쾌하고 깔끔한 멘솔. 글로 사용자들의 기본 템.", "heat", "stick", "neo_fresh.jpg"));
        products.add(new Product("16", "네오(Neo) 퍼플 부스트", "4,800", "캡슐을 깨물면 터지는 진한 포도 맛. 글로 스틱 중 판매량 1위.", "heat", "stick", "neo_purple.jpg"));

        // 2. 액상형 입호흡 기기 
        products.add(new Product("17", "유웰 발라리안", "55,000", "좀비 코일이라 불리는 엄청난 수명", "liquid", "mtl", "valyrian.jpg"));
        products.add(new Product("18", "아보카도 베이비", "50,000", "귀여운 디자인과 파스텔 톤 색감", "liquid", "mtl", "avocado.jpg"));
     	products.add(new Product("19", "아스파이어 고텍 X", "24,000", "속이 보이는 투명한 사이버펑크 디자인. 4.5ml 괴물 용량 팟으로 하루 종일 베이핑 가능.", "liquid", "mtl", "gotek.jpg"));
     	products.add(new Product("20", "린코 젤리박스 XS", "45,000", "삐삐(페이저) 감성 디자인. 힙한 레트로 스타일을 좋아한다면 필수템.", "liquid", "mtl", "jellybox_xs.jpg"));
        
        // 2-1 액상형 폐호흡 기기 
        products.add(new Product("21", "제우스 서브옴 탱크", "45,000", "폐호흡 무화기 끝판왕", "liquid", "dtl", "zeus.jpg"));
        products.add(new Product("22", "긱베이프 이지스 레전드 2 (L200)", "78,000", "폐호흡 기기의 교과서. IP68 방수 방진 등급으로 내구성이 압도적이며 밀어주는 힘이 강력합니다.", "liquid", "dtl", "legend2.jpg"));
        products.add(new Product("23", "베이포레소 젠 200", "65,000", "두발 기기 중 가장 가벼운 무게. 심플한 디자인과 강력한 펄스 모드로 맛 표현을 극대화했습니다.", "liquid", "dtl", "gen200.jpg"));
        products.add(new Product("24", "유웰 발라리안 3 킷", "95,000", "용의 비늘을 형상화한 디자인. 발라리안의 명성 그대로 진한 맛 표현과 엄청난 무화량.", "liquid", "dtl", "valyrian3.jpg"));
	        
        // 2-2 액상 
	    
	    products.add(new Product("25", "알케마스터 자몽", "28,000", "상큼한 리얼 자몽 맛의 정석. 질리지 않는 데일리 액상 부동의 1위.", "juice", "mtl", "alche_grapefruit.jpg"));
	    products.add(new Product("26", "블랙유니콘 쿠반 시가", "30,000", "타격감이 매우 강한 솔트 니코틴 액상. 진짜 담배를 피우는 듯한 묵직함.", "juice", "mtl", "blvk_cuban.jpg"));
	    products.add(new Product("27", "잼몬스터 스트로베리", "32,000", "버터 바른 토스트에 딸기 잼을 듬뿍 바른 맛. 살찌는 맛이라 더 맛있습니다.", "juice", "dtl", "jam_strawberry.jpg"));
	    products.add(new Product("28", "크림 오브 더 크롭(CTOC)", "35,000", "낙엽 밟는 냄새라 불리는 고급진 크림 연초 향. 숙성될수록 맛이 깊어집니다.", "juice", "dtl", "ctoc.jpg"));
        
        // 3. 일회용 전담 
        products.add(new Product("29", "엘프바 10000", "19,000", "대용량 일회용의 정석", "disposable", "", "elfbar.jpg"));
        products.add(new Product("30", "퍼프미 10000", "23,000", "심플하고 모던한 디자인. 충전 속도가 매우 빠르고 맛 변화가 적습니다.", "disposable", "", "puffmi_10000.jpg"));
        products.add(new Product("31", "플럼 페블", "21,000", "조약돌처럼 둥글둥글하고 부드러운 촉감. 그립감이 너무 좋아서 자꾸 만지게 됨.", "disposable", "", "flum_pebble.jpg"));
        products.add(new Product("32", "보졸 기어 10000", "26,000", "카라비너(고리)가 달려있어 가방에 걸 수 있는 아웃도어용 기기. 캡이 있어 위생적.", "disposable", "", "vozol_gear.jpg"));
    }

    // 전체 상품 가져오기
    public static List<Product> getAllProducts() {
        return products;
    }

    // ID로 상품 하나 찾기 (상세페이지용)
    public static Product getProductById(String id) {
        for(Product p : products) {
            if(p.getId().equals(id)) return p;
        }
        return null; // 없으면 null 반환
    }
    
    public static List<Product> getSortedProducts(String type, String sub, String sort) {
        // 1. 일단 카테고리에 맞는 제품들을 다 가져옴
        List<Product> targetList = getProductsByCategory(type, sub);
        
        // 2. 원본 보호를 위해 복사본 생성
        List<Product> sortedList = new ArrayList<>(targetList);

        // 3. 정렬 로직
        if (sort == null || sort.equals("") || sort.equals("pop")) {
            // [인기순] 리뷰 개수가 많은 순서대로
            Collections.sort(sortedList, (p1, p2) -> 
                ReviewRepository.getReviewCount(p2.getId()) - ReviewRepository.getReviewCount(p1.getId())
            );
        } else if (sort.equals("high")) {
            // [평점 높은순]
            Collections.sort(sortedList, (p1, p2) -> Double.compare(
                ReviewRepository.getAverageRating(p2.getId()), 
                ReviewRepository.getAverageRating(p1.getId())
            ));
        } else if (sort.equals("low")) {
            // [평점 낮은순]
            Collections.sort(sortedList, (p1, p2) -> Double.compare(
                ReviewRepository.getAverageRating(p1.getId()), 
                ReviewRepository.getAverageRating(p2.getId())
            ));
        } else if (sort.equals("price_high")) {
            // [높은 가격순] "55,000" -> 55000 으로 바꿔서 비교
            Collections.sort(sortedList, (p1, p2) -> {
                int price1 = Integer.parseInt(p1.getPrice().replace(",", ""));
                int price2 = Integer.parseInt(p2.getPrice().replace(",", ""));
                return price2 - price1;
            });
        } else if (sort.equals("price_low")) {
            // [낮은 가격순]
            Collections.sort(sortedList, (p1, p2) -> {
                int price1 = Integer.parseInt(p1.getPrice().replace(",", ""));
                int price2 = Integer.parseInt(p2.getPrice().replace(",", ""));
                return price1 - price2;
            });
        }
        
        return sortedList;
    }
    
    public static List<Product> searchProducts(String keyword) {
        List<Product> result = new ArrayList<>();
        
        // 검색어가 없으면 빈 리스트 반환
        if(keyword == null || keyword.trim().equals("")) {
            return result;
        }

        // 대소문자 구분 없이 검색하기 위해 소문자로 변환
        String lowerKeyword = keyword.toLowerCase();

        for(Product p : products) {
            // 제품 이름이나 설명에 검색어가 포함되어 있는지 확인
            if(p.getName().toLowerCase().contains(lowerKeyword) || 
               p.getDesc().toLowerCase().contains(lowerKeyword)) {
                result.add(p);
            }
        }
        return result;
    }
    
    // 카테고리별로 상품 찾기 (리스트페이지용)
    public static List<Product> getProductsByCategory(String type, String sub) {
        List<Product> result = new ArrayList<>();
        for(Product p : products) {
            // type(궐련/액상)이 같고
            if(p.getType().equals(type)) {
                // sub(기기/스틱)가 비어있거나(전체보기) 일치하면 추가
                if(sub == null || sub.equals("") || p.getSub().equals(sub)) {
                    result.add(p);
                }
            } else if (type != null && type.equals("disposable") && p.getType().equals("disposable")) {
                // 일회용인 경우
                result.add(p);
            }
        }
        return result;
    }
}