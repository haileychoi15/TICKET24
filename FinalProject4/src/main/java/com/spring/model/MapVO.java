package com.spring.model;

public class MapVO {
	
	private String prod_id;
	private String map_id;
	private String map_name;
	private String map_address;
	private String local;
	private String map_lng;
	private String map_lat;
	private String map_url;
	
	public MapVO() {}
	
	public MapVO(String prod_id, String map_id, String map_name, String map_address, String local, String map_lng,
			String map_lat, String map_url) {
		super();
		this.prod_id = prod_id;
		this.map_id = map_id;
		this.map_name = map_name;
		this.map_address = map_address;
		this.local = local;
		this.map_lng = map_lng;
		this.map_lat = map_lat;
		this.map_url = map_url;
	}

	public String getProd_id() {
		return prod_id;
	}

	public void setProd_id(String prod_id) {
		this.prod_id = prod_id;
	}

	public String getMap_id() {
		return map_id;
	}

	public void setMap_id(String map_id) {
		this.map_id = map_id;
	}

	public String getMap_name() {
		return map_name;
	}

	public void setMap_name(String map_name) {
		this.map_name = map_name;
	}

	public String getMap_address() {
		return map_address;
	}

	public void setMap_address(String map_address) {
		this.map_address = map_address;
	}

	public String getLocal() {
		return local;
	}

	public void setLocal(String local) {
		this.local = local;
	}

	public String getMap_lng() {
		return map_lng;
	}

	public void setMap_lng(String map_lng) {
		this.map_lng = map_lng;
	}

	public String getMap_lat() {
		return map_lat;
	}

	public void setMap_lat(String map_lat) {
		this.map_lat = map_lat;
	}

	public String getMap_url() {
		return map_url;
	}

	public void setMap_url(String map_url) {
		this.map_url = map_url;
	}
	
	
	
}
