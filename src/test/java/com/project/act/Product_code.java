package com.project.act;

public class Product_code{
	public static void main(String[] args) {
		String product_name = "U오버사이즈크루넥T_스프라이트";
		int manufact_year = 2019;
		String manufact_seas = "SS";
		String sex = "M";
		String category1 = "T";
		String category2 = "crewneck_T";
		String fit = "oversize_fit";
		String color = "WHITE";
		String sizes = "XL";
		int factory_code = 1;
		long head_stock_quantity = 0;
		String product_code = manufact_year+manufact_seas+"-"
				+sex+category1+"-"
				+product_name
				+"("+color+"-"+sizes+")";
		String img_name=product_code+".jpg";
		long price = 19900;
		
		
		
		StringBuffer sql = new StringBuffer();
		sql.append("insert into product(product_code,product_name,manufact_year,manufact_seas");
		sql.append(",sex,category1,category2,fit,color,sizes,factory_code");
		sql.append(",head_stock_quantity,img_name,price)");
		sql.append("values('"+product_code+"','"+product_name+"',"+manufact_year+",'"+manufact_seas+"','");
		sql.append(sex+"','"+category1+"','"+category2+"','"+fit+"','"+color+"','"+sizes+"',"+factory_code+",");
		sql.append(head_stock_quantity+",'"+img_name+"',"+price+")");
		
		System.out.println(sql.toString());
	}
}
