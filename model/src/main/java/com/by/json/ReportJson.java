package com.by.json;

public class ReportJson extends BaseReportJson{

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
		private String[] data;
		private String stack;
		private AreaStyle areaStyle;
		
		public class AreaStyle {
			private String normal;

			public String getNormal() {
				return normal;
			}

			public void setNormal(String normal) {
				this.normal = normal;
			}
		};

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

		public String[] getData() {
			return data;
		}

		public void setData(String[] data) {
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

		public String getStack() {
			return stack;
		}

		public void setStack(String stack) {
			this.stack = stack;
		}

		public AreaStyle getAreaStyle() {
			return areaStyle;
		}

		public void setAreaStyle(AreaStyle areaStyle) {
			this.areaStyle = areaStyle;
		}
		
	}

}
