package com.by.json;

public class BaseReportJson {

	private Title title;
	private Tooltip tooltip;
	private Legend legend;
	private XAxis xAxis;
	private YAxis yAxis;

	public Title getTitle() {
		return title;
	}

	public void setTitle(Title title) {
		this.title = title;
	}

	public Legend getLegend() {
		return legend;
	}

	public void setLegend(Legend legend) {
		this.legend = legend;
	}

	public XAxis getxAxis() {
		return xAxis;
	}

	public void setxAxis(XAxis xAxis) {
		this.xAxis = xAxis;
	}

	public Tooltip getTooltip() {
		return tooltip;
	}

	public void setTooltip(Tooltip tooltip) {
		this.tooltip = tooltip;
	}

	public YAxis getyAxis() {
		return yAxis;
	}

	public void setyAxis(YAxis yAxis) {
		this.yAxis = yAxis;
	}

	public class Title {
		private String text;
		private String subtext = "";
		private String x = "";

		public String getText() {
			return text;
		}

		public void setText(String text) {
			this.text = text;
		}

		public String getSubtext() {
			return subtext;
		}

		public void setSubtext(String subtext) {
			this.subtext = subtext;
		}

		public String getX() {
			return x;
		}

		public void setX(String x) {
			this.x = x;
		}

	}

	public class Tooltip {
		private String show = "true";
		private String trigger;
		private String formatter = "";

		public String getShow() {
			return show;
		}

		public void setShow(String show) {
			this.show = show;
		}

		public String getTrigger() {
			return trigger;
		}

		public void setTrigger(String trigger) {
			this.trigger = trigger;
		}

		public String getFormatter() {
			return formatter;
		}

		public void setFormatter(String formatter) {
			this.formatter = formatter;
		}

	}

	public class Legend {
		private String[] data;

		public String[] getData() {
			return data;
		}

		public void setData(String[] data) {
			this.data = data;
		}
	}

	public class XAxis {
		private String[] data;
		private String type;
		private Boolean boundaryGap;

		public String[] getData() {
			return data;
		}

		public void setData(String[] data) {
			this.data = data;
		}

		public String getType() {
			return type;
		}

		public void setType(String type) {
			this.type = type;
		}

		public Boolean getBoundaryGap() {
			return boundaryGap;
		}

		public void setBoundaryGap(Boolean boundaryGap) {
			this.boundaryGap = boundaryGap;
		}

	}

	public class YAxis {
		private String name;
		private String value;

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public String getValue() {
			return value;
		}

		public void setValue(String value) {
			this.value = value;
		}

	}

}
