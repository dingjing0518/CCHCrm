package com.by.json;

public class PieReportJson extends BaseReportJson {

	private Series[] series;

	public Series[] getSeries() {
		return series;
	}

	public void setSeries(Series[] series) {
		this.series = series;
	}

	public class Series {
		private String name;
		private String type;
		private String radius = "";
		private String[] center = new String[] { "" };
		private PieData[] data;

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public String getType() {
			return type;
		}

		public void setType(String type) {
			this.type = type;
		}

		public PieData[] getData() {
			return data;
		}

		public void setData(PieData[] data) {
			this.data = data;
		}

		public String getRadius() {
			return radius;
		}

		public void setRadius(String radius) {
			this.radius = radius;
		}

		public String[] getCenter() {
			return center;
		}

		public void setCenter(String[] center) {
			this.center = center;
		}
	}

	public class PieData {
		private String value;
		private String name;

		public String getValue() {
			return value;
		}

		public void setValue(String value) {
			this.value = value;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

	}

}
