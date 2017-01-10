package com.hs.web.service;

//import com.skt.ibt.Global;
//import com.skt.ibt.PathManager;
//import com.skt.ibt.ServiceBase;
//import com.skt.ibt.res.ResManager;
//import com.skt.ibt.util.CircleDrawer;
//import com.skt.ibt.util.MySpiderWebPlot;
//import com.skt.ibt.util.UnitUtil;
import com.hs.DbList;
import com.hs.DbMap;
import com.hs.util.UnitUtil;
import com.hs.web.Global;
import com.hs.web.PathManager;
//import com.hs.web.ResManager;
import com.hs.web.ServiceBase;
import com.hs.web.util.CircleDrawer;
import com.hs.web.util.MySpiderWebPlot;
import org.jfree.chart.*;
import org.jfree.chart.annotations.XYDrawableAnnotation;
import org.jfree.chart.annotations.XYImageAnnotation;
import org.jfree.chart.annotations.XYLineAnnotation;
import org.jfree.chart.annotations.XYTextAnnotation;
import org.jfree.chart.axis.*;
import org.jfree.chart.entity.StandardEntityCollection;
import org.jfree.chart.labels.StandardCategoryItemLabelGenerator;
import org.jfree.chart.labels.StandardXYItemLabelGenerator;
import org.jfree.chart.plot.*;
import org.jfree.chart.renderer.category.BarRenderer;
import org.jfree.chart.renderer.category.CategoryItemRenderer;
import org.jfree.chart.renderer.category.LineAndShapeRenderer;
import org.jfree.chart.renderer.category.StandardBarPainter;
import org.jfree.chart.renderer.xy.*;
import org.jfree.chart.title.LegendTitle;
import org.jfree.chart.title.TextTitle;
import org.jfree.data.DefaultKeyedValues;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.general.DatasetUtilities;
import org.jfree.data.xy.*;
import org.jfree.ui.*;
import org.jfree.util.ShapeUtilities;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.swing.*;
import java.awt.*;
import java.awt.geom.Rectangle2D;
import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;

import static java.awt.Color.*;

@Service
public class GraphService extends ServiceBase
{
    private static final Logger logger = LoggerFactory.getLogger(GraphService.class);
	
	@Autowired
	private PathManager pathManager;
	private final static String FONT_NAME = "백묵 굴림";//"맑은 고딕";//"돋움";// = "백묵 굴림";
//
//	@Autowired
//	private ResManager resManager;
	
	private final StandardChartTheme _theme;
	
	public GraphService()
    {
        if(Global.isDev){
            GraphicsEnvironment e = GraphicsEnvironment.getLocalGraphicsEnvironment();
		    String[] fonts = e.getAvailableFontFamilyNames();//Font[] font = e.getAllFonts();

            for(String f: fonts)
            {
                logger.info("loaded.. font={}", f);
            }
        }

		  
	    StandardChartTheme theme = (StandardChartTheme) StandardChartTheme.createJFreeTheme();

//	    theme.setTitlePaint( Color.decode( "#4572a7" ) );
	    theme.setExtraLargeFont( new Font(FONT_NAME,Font.PLAIN, 16) ); //title
	    theme.setLargeFont( new Font(FONT_NAME,Font.BOLD, 15)); //axis-title
	    theme.setRegularFont( new Font(FONT_NAME,Font.PLAIN, 11));

//	    theme.setRangeGridlinePaint( Color.decode("#C0C0C0"));
	    theme.setPlotBackgroundPaint( white );
	    theme.setChartBackgroundPaint( white );
//	    theme.setGridBandPaint( Color.red );
//	    theme.setAxisOffset( new RectangleInsets(0,0,0,0) );
//	    theme.setBarPainter(new StandardBarPainter());
//	    theme.setAxisLabelPaint( Color.decode("#666666")  );
//	    theme.apply( chart );

	    _theme = theme;
	}

	XYSeriesCollection createDataset1(DbList list, XYSeriesCollection dataset,String name) {


		XYSeries series1 = new XYSeries(name);

		for(DbMap a :list){
			double x = UnitUtil.toDouble(a.get("x") + "");
			double y = UnitUtil.toDouble(a.get("y") + "");
			series1.add(x, y);
		}


		dataset.addSeries(series1);

		return dataset;

	}



	/**
	 * 일반 막대 그래프.
	 * @param map
	 * @param keyedValues
	 * @param myScore
	 * @param isInvert : y axis 의 값이 역순인지 아닌지
	 * @param //viewDistance : 막대들의 값 차이를 표시할지 않할지
	 * @param width
	 * @param height
	 * @return
	 * @throws IOException
	 */
	public String createGraphic1(HashMap<String, Object> map, DefaultKeyedValues keyedValues, double myScore, Boolean isInvert, int width, int height) throws IOException
    {
		CategoryDataset dataset = DatasetUtilities.createCategoryDataset("", keyedValues);
		final JFreeChart chart = createChart(dataset, myScore, isInvert, width);
		File file = pathManager.getGrpFile(map);
		String path = file.getPath();
		saveTo(chart, width, height, file);

        return pathManager.getRelativePath(path, true);
	}

	/**
	 * 꺽은선 그래프
	 * @param map
	 * @param dataset
	 * @param targetScore
	 * @param isInvert : y axis 의 값이 역순인지 아닌지
	 * @param width
	 * @param height
	 * @return
	 * @throws IOException
	 */
	public String createGraphic2(HashMap<String, Object> map, CategoryDataset dataset, double targetScore,  Boolean isInvert, int width, int height) throws IOException
    {
		final JFreeChart chart = createChart2(dataset, targetScore, isInvert);
		File file = pathManager.getGrpFile(map);
		String path = file.getPath();
		saveTo(chart, width, height, file);

        return pathManager.getRelativePath(path, true);
	}

	/**
	 * 꺾은선 그래프 (1개 데이타)
	 * @param map
	 * @param keyedValues
	 * @param targetScore
	 * @param isInvert : y axis 의 값이 역순인지 아닌지
	 * @param width
	 * @param height
	 * @return
	 * @throws IOException
	 */
	public String createGraphic2(HashMap<String, Object> map, DefaultKeyedValues keyedValues, double targetScore, Boolean isInvert, int width, int height) throws IOException
    {
		CategoryDataset dataset = DatasetUtilities.createCategoryDataset("", keyedValues);
		return createGraphic2(map, dataset, targetScore, isInvert, width, height);
	}

	/**
	 * 가로 막대 그래프.
	 * @param map
	 * @param keyedValues
	 * @param width
	 * @param height
	 * @return
	 * @throws IOException
	 */
	public String createGraphic3(HashMap<String, Object> map, DefaultKeyedValues keyedValues, int width, int height) throws IOException
    {
		CategoryDataset dataset = DatasetUtilities.createCategoryDataset("", keyedValues);
		final JFreeChart chart = createChart3(dataset, width);
		File file = pathManager.getGrpFile(map);
		String path = file.getPath();
		saveTo(chart, width, height, file);

        return pathManager.getRelativePath(path, true);
	}

	/**
	 * 스파이더 형 그래프.
	 * @param map
	 * @param localDefaultCategoryDataset
	 * @param width
	 * @param height
	 * @return
	 * @throws IOException
	 */
	public String createGraphic4(HashMap<String, Object> map, DefaultCategoryDataset localDefaultCategoryDataset, int width, int height) throws IOException
    {
        final JFreeChart chart = createChart4(localDefaultCategoryDataset);
		File file = pathManager.getGrpFile(map);
		String path = file.getPath();
		saveTo(chart, width, height, file);

        return pathManager.getRelativePath(path, true);
	}

	/**
	 * 스파이더 형 그래프. 01
	 * @param map
	 * @param localDefaultCategoryDataset
	 * @param width
	 * @param height
	 * @return
	 * @throws IOException
	 */
	public String createGraphic4_1(HashMap<String, Object> map, DefaultCategoryDataset localDefaultCategoryDataset, int width, int height) throws IOException
    {
        final JFreeChart chart = createChart4_1(localDefaultCategoryDataset);
		File file = pathManager.getGrpFile(map);
		String path = file.getPath();
		saveTo(chart, width, height, file);

        return pathManager.getRelativePath(path, true);
	}

	/**
	 * 분포도 그래프.
	 * @param map
	 * @param //localDefaultCategoryDataset
	 * @param width
	 * @param height
	 * @return
	 * @throws IOException
	 */
	public String createGraphic5(HashMap<String, Object> map, XYSeries localXYSeries, double avg, double avg_per, double myscore, int width, int height) throws IOException
    {
		XYSeriesCollection dataset = new XYSeriesCollection(localXYSeries);
		final JFreeChart chart = createChart5(dataset, avg, avg_per, myscore, height);

		File file = pathManager.getGrpFile(map);
		String path = file.getPath();
		saveTo(chart, width, height, file);

        return pathManager.getRelativePath(path, true);
	}


	/**
	 * 정규 표준 편차 그래프.
	 * @param //localDefaultCategoryDataset
	 * @param map
	 * @param width
	 * @param height
	 * @return
	 * @throws IOException
	 */
	public String createGraphic6(HashMap<String, Object> map, XYSeriesCollection localXYSeriesCollection, ArrayList<HashMap<String, Object>> gradeValues, int width, int height) throws IOException
    {
		final JFreeChart chart = createChart6(localXYSeriesCollection, gradeValues, height);

		File file = pathManager.getGrpFile(map);
		String path = file.getPath();
		saveTo(chart, width, height, file);

        return pathManager.getRelativePath(path, true);
	}



	/**
	 * 꺾은선 그래프 (1개 데이타)
	 * @param map
	 * @param //keyedValues
	 * @param //targetScore
	 * @param //isInvert : y axis 의 값이 역순인지 아닌지
	 * @param width
	 * @param height
	 * @return
	 * @throws IOException
	 */
	public String createGraphic7(HashMap<String, Object> map, XYSeriesCollection dataset, String text,
				double textXPosition, double textYPosition, TextAnchor textAnchor, int width, int height)
																							throws IOException
    {

		final JFreeChart chart = createChart7(dataset, text, textXPosition, textYPosition, textAnchor);

		File file = pathManager.getGrpFile(map);
		String path = file.getPath();
		saveTo(chart, width, height, file);

        return pathManager.getRelativePath(path, true);
	}

	/**
	 * 일반 막대 그래프 - 막대간 VALUE 차이 표시.
	 * @param map
	 * @param localXYSeriesCollection
	 * @param //distanceValue : 백분율 차이를 그려주는 것과 관련된 데이터.
	 * @param width
	 * @param height
	 * @return
	 * @throws IOException
	 */
	public String createGraphic8(HashMap<String, Object> map, XYSeriesCollection localXYSeriesCollection,
									XYSeries distance, Boolean isInvert, String title1, String title2,
									int width, int height) throws IOException
    {

		IntervalXYDataset dataset = new XYBarDataset(localXYSeriesCollection, 1.0);
		final JFreeChart chart = createChart8(dataset, distance, isInvert, title1, title2);
		File file = pathManager.getGrpFile(map);
		String path = file.getPath();
		saveTo(chart, width, height, file);

        return pathManager.getRelativePath(path, true);
	}


	/**
	 * 일반 막대 그래프 + 꺾은선그래프
	 * @param //distanceValue : 백분율 차이를 그려주는 것과 관련된 데이터.
	 * @param map
	 * @param dataset1
	 * @param dataset2
	 * @param width
	 * @param height
	 * @return
	 * @throws IOException
	 */
	public String createGraphicBarLine(HashMap<String, Object> map,
								 DefaultCategoryDataset dataset1,
								 DefaultCategoryDataset dataset2,
								 int width, int height) throws IOException
    {

		final JFreeChart chart = createChartBarLine(dataset1, dataset2);
		File file = pathManager.getGrpFile(map);
		String path = file.getPath();
		saveTo(chart, width, height, file);

        return pathManager.getRelativePath(path, true);
	}



	/**
	 * multi y axis
	 * @param //distanceValue : 백분율 차이를 그려주는 것과 관련된 데이터.
	 * @param map
	 * @param list
	 * @param width
	 * @param height
	 * @return
	 * @throws IOException
	 */
	public String
	createGraphicMultiAxis(HashMap<String, Object> map,
										 DbList list ,
									   int width, int height) throws IOException
	{
		final JFreeChart chart = createChartMultiAxis(list);

		File file = pathManager.getGrpFile(map);
		String path = file.getPath();
		saveTo(chart, width, height, file);


		return pathManager.getRelativePath(path, true);
	}

	/**
	 * multi y axis time series
	 * @param //distanceValue : 백분율 차이를 그려주는 것과 관련된 데이터.
	 * @param map
	 * @param list
	 * @param width
	 * @param height
	 * @return
	 * @throws IOException
	 */
	public String
	createChartMultiAxisTime(HashMap<String, Object> map,
										 DbList list ,
									   int width, int height) throws IOException
	{
		final JFreeChart chart = createChartMultiAxisTime(list);

		File file = pathManager.getGrpFile(map);
		String path = file.getPath();
		saveTo(chart, width, height, file);


		return pathManager.getRelativePath(path, true);
	}



/////////////////////////////////////////////////save to file


	private void saveTo(JFreeChart chart, int width, int height, File file)
			throws IOException
    {
//		chart.setBackgroundPaint(new Color(255, 255, 255));
		final ChartRenderingInfo info = new ChartRenderingInfo(
				new StandardEntityCollection());
		ChartUtilities.saveChartAsPNG(file, chart, width, height, info);
	}

	// 일반 막대그래프.
	private JFreeChart createChart(CategoryDataset paramCategoryDataset, double myScore, Boolean isInvert, int width)
    {
		JFreeChart localJFreeChart = ChartFactory.createBarChart(null, null,
				null, paramCategoryDataset, PlotOrientation.VERTICAL, false,
				true, false);
		_theme.apply(localJFreeChart);

		CategoryPlot localCategoryPlot = (CategoryPlot) localJFreeChart.getPlot();
		localCategoryPlot.setBackgroundPaint(Color.WHITE);
		localCategoryPlot.setRangePannable(true);
		localCategoryPlot.setRangeZeroBaselineVisible(true);
		localCategoryPlot.setDomainGridlinesVisible(false);
		localCategoryPlot.setDomainGridlinePaint(gray);
		localCategoryPlot.setRangeGridlinesVisible(true);
		localCategoryPlot.setRangeGridlinePaint(gray);
		localCategoryPlot.getRangeAxis().setInverted(isInvert);

		NumberAxis localNumberAxis = (NumberAxis) localCategoryPlot.getRangeAxis();
		localNumberAxis.setUpperMargin(0.15D);
		localNumberAxis.setLowerBound(0.0d);

		// 모든 value가 0 일 경우 tick unit 을 int로 고정.
		Boolean valueExist = false;
		for (int i = 0 ; i < paramCategoryDataset.getRowCount(); i++)
        {
			for (int j = 0 ; j < paramCategoryDataset.getColumnCount(); j++)
            {
				if(UnitUtil.toDouble(paramCategoryDataset.getValue(i, j)) > 0.0d)
                {
					valueExist = true;
					break;
				}
			}
		}
		if(!valueExist)
        {
			localNumberAxis.setStandardTickUnits(NumberAxis.createIntegerTickUnits());
		}

		CategoryItemRenderer localCategoryItemRenderer = localCategoryPlot.getRenderer();
		localCategoryItemRenderer.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator());
		localCategoryItemRenderer.setSeriesItemLabelsVisible(0, true);

		double maxWidth = 20;

		BarRenderer barRenderer = (BarRenderer) localCategoryPlot.getRenderer();
		barRenderer.setShadowVisible(false);
		barRenderer.setBarPainter(new StandardBarPainter());
		barRenderer.setMaximumBarWidth(Math.round(( maxWidth / width) * Math.pow(10, 2)) / Math.pow(10, 2));

		// y axis의 value 가 위에서 부터 0일때
		localNumberAxis.setRange(0, 100);
		if(isInvert)
        {
			barRenderer.setBase(100);
		}

		GradientPaint localGradientPaint1 = new GradientPaint(0.0f, 0.0f, new Color(60, 96, 240),   0.0f, 0.0f, new Color(104, 146, 252));
		localCategoryItemRenderer.setSeriesPaint(0, localGradientPaint1);
		localCategoryItemRenderer.setSeriesOutlinePaint(0, blue);

		if(myScore > -1d)
        {
			localCategoryPlot.getDomainAxis().setUpperMargin(0.20d);

			ValueMarker localValueMarker1 = new ValueMarker(myScore);
			localValueMarker1.setLabelOffsetType(LengthAdjustmentType.EXPAND);
			localValueMarker1.setPaint(Color.RED);
			localValueMarker1.setStroke(new BasicStroke(2.0F));
			localValueMarker1.setLabel("나의점수");
			localValueMarker1.setLabelFont(new Font(FONT_NAME, 0, 11));
			localValueMarker1.setLabelPaint(red);
			localValueMarker1.setLabelAnchor(RectangleAnchor.RIGHT);
			localValueMarker1.setLabelTextAnchor(TextAnchor.BOTTOM_RIGHT);
			localCategoryPlot.addRangeMarker(localValueMarker1);
		}


		return localJFreeChart;
	}

	// 꺽은선 그래프.
	private JFreeChart createChart2(CategoryDataset paramCategoryDataset, double targetScore, Boolean isInvert)
    {
		JFreeChart localJFreeChart = ChartFactory.createLineChart(null, null,
				null, paramCategoryDataset, PlotOrientation.VERTICAL, false,
				true, false);
		_theme.apply(localJFreeChart);
		localJFreeChart.setBackgroundPaint(Color.WHITE);
		CategoryPlot localCategoryPlot = (CategoryPlot) localJFreeChart.getPlot();
		localCategoryPlot.setBackgroundPaint(Color.WHITE);
		localCategoryPlot.setDomainGridlinesVisible(true);
		localCategoryPlot.setDomainGridlinePaint(gray);
		localCategoryPlot.setRangeGridlinesVisible(true);
		localCategoryPlot.setRangeGridlinePaint(gray);
		localCategoryPlot.getRangeAxis().setInverted(isInvert);

		if(targetScore > -1d)
        {
			localCategoryPlot.getDomainAxis().setUpperMargin(0.20d);

			ValueMarker localValueMarker1 = new ValueMarker(targetScore);
			localValueMarker1.setLabelOffsetType(LengthAdjustmentType.EXPAND);
			localValueMarker1.setPaint(Color.RED);
			localValueMarker1.setStroke(new BasicStroke(2.0F));
			localValueMarker1.setLabel("지원등급");
			localValueMarker1.setLabelFont(new Font(FONT_NAME, 0, 11));
			localValueMarker1.setLabelPaint(red);
			localValueMarker1.setLabelAnchor(RectangleAnchor.RIGHT);
			localValueMarker1.setLabelTextAnchor(TextAnchor.BOTTOM_RIGHT);
			localCategoryPlot.addRangeMarker(localValueMarker1);
		}

		NumberAxis localNumberAxis = (NumberAxis) localCategoryPlot.getRangeAxis();
		localNumberAxis.setUpperMargin(0.15D);
		localNumberAxis.setLowerBound(0.0d);
		localNumberAxis.setStandardTickUnits(NumberAxis.createIntegerTickUnits());
		LineAndShapeRenderer localLineAndShapeRenderer = (LineAndShapeRenderer) localCategoryPlot.getRenderer();
		localLineAndShapeRenderer.setBaseShapesVisible(true);
		localLineAndShapeRenderer.setDrawOutlines(true);
		localLineAndShapeRenderer.setUseFillPaint(true);
		localLineAndShapeRenderer.setBaseFillPaint(Color.BLUE);
		localLineAndShapeRenderer.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator());
		localLineAndShapeRenderer.setSeriesItemLabelsVisible(0, true);

		return localJFreeChart;
	}

	// 가로 막대 그래프.
	private JFreeChart createChart3(CategoryDataset paramCategoryDataset, int width)
    {
		JFreeChart localJFreeChart = ChartFactory.createBarChart(
                                                                  null, null,null, paramCategoryDataset,
                                                                  PlotOrientation.HORIZONTAL, false, true, false);
		_theme.apply(localJFreeChart);

		localJFreeChart.setBackgroundPaint(Color.WHITE);
		CategoryPlot localCategoryPlot = (CategoryPlot) localJFreeChart.getPlot();
		localCategoryPlot.setBackgroundPaint(Color.WHITE);
		localCategoryPlot.setRangeAxisLocation(AxisLocation.BOTTOM_OR_LEFT);
		localCategoryPlot.setRangePannable(true);
		localCategoryPlot.setRangeZeroBaselineVisible(true);
		localCategoryPlot.setDomainGridlinesVisible(false);
		localCategoryPlot.setDomainGridlinePaint(gray);
		localCategoryPlot.setRangeGridlinesVisible(true);
		localCategoryPlot.setRangeGridlinePaint(gray);
		NumberAxis localNumberAxis = (NumberAxis) localCategoryPlot.getRangeAxis();
		localNumberAxis.setUpperMargin(0.25D);
		CategoryItemRenderer localCategoryItemRenderer = localCategoryPlot.getRenderer();
		localCategoryItemRenderer.setBaseItemLabelsVisible(true);
		localCategoryItemRenderer.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator());

		double maxWidth = 40;

		BarRenderer barRenderer = (BarRenderer) localCategoryPlot.getRenderer();
		barRenderer.setShadowVisible(false);
		barRenderer.setBarPainter(new StandardBarPainter());
		barRenderer.setMaximumBarWidth(Math.round((maxWidth / width) * Math.pow(10, 2)) / Math.pow(10, 2));

		GradientPaint localGradientPaint1 = new GradientPaint(0.0f, 0.0f, new Color(60, 96, 240),   0.0f, 0.0f, new Color(104, 146, 252));
		localCategoryItemRenderer.setSeriesPaint(0, localGradientPaint1);
		localCategoryItemRenderer.setSeriesOutlinePaint(0, blue);

		return localJFreeChart;
	}

	// 라이더 형태 그래프.
	private JFreeChart createChart4(CategoryDataset paramCategoryDataset)
    {
		SpiderWebPlot localSpiderWebPlot = new MySpiderWebPlot(paramCategoryDataset);
		localSpiderWebPlot.setBackgroundPaint(Color.WHITE);
		JFreeChart localJFreeChart = new JFreeChart(null,TextTitle.DEFAULT_FONT, localSpiderWebPlot, false);
		_theme.apply(localJFreeChart);

		localJFreeChart.setBackgroundPaint(Color.WHITE);
		LegendTitle localLegendTitle = new LegendTitle(localSpiderWebPlot);
		localLegendTitle.setPosition(RectangleEdge.LEFT);
		localLegendTitle.setItemFont(new Font(FONT_NAME, 0, 11));

		localJFreeChart.addSubtitle(localLegendTitle);

		localSpiderWebPlot.setMaxValue(100.0d);
		return localJFreeChart;
	}

	// 라이더 형태 그래프.- 1
	private JFreeChart createChart4_1(CategoryDataset paramCategoryDataset)
    {
		SpiderWebPlot localSpiderWebPlot = new SpiderWebPlot(paramCategoryDataset);
		localSpiderWebPlot.setBackgroundPaint(Color.WHITE);
		JFreeChart localJFreeChart = new JFreeChart(null,TextTitle.DEFAULT_FONT, localSpiderWebPlot, false);
		_theme.apply(localJFreeChart);

		//축 없앰
		localSpiderWebPlot.setAxisLinePaint(white);

		localSpiderWebPlot.setHeadPercent(0.01);
		localSpiderWebPlot.setSeriesPaint(0, new Color(203, 203, 212));//기준선
		localSpiderWebPlot.setSeriesPaint(1, blue);//득점
		localSpiderWebPlot.setSeriesPaint(2, red);//평균
		localSpiderWebPlot.setMaxValue(100.0d);
		localSpiderWebPlot.setSeriesOutlineStroke(0, new BasicStroke(0.01f));//기준선굵기
		localSpiderWebPlot.setSeriesOutlineStroke(1,new BasicStroke(2.0f));//득점선굵기

		//라벨벨류
		localSpiderWebPlot.setLabelGenerator(new StandardCategoryItemLabelGenerator()
        {
			@Override
			public String generateColumnLabel(CategoryDataset dataset, int col)
            {
				Number val = dataset.getValue(1, col);
				return dataset.getColumnKey(col) + " " + Math.round((Double) val)+"%";
			}
		});
//		Number val = paramCategoryDataset.getValue(1, 1);
//		logger.info("val : "+val);
//		NumberFormat format = NumberFormat.getNumberInstance();
//		localSpiderWebPlot.setLabelGenerator(new StandardCategoryItemLabelGenerator(StandardXYItemLabelGenerator.DEFAULT_ITEM_LABEL_FORMAT,format,format));
//		StandardCategoryItemLabelGenerator labelGenerator = null;
//		labelGenerator = paramCategoryDataset.getD
		//((FillSpiderDataset)spiderchartBean.getDataset()).getLabelGenerator();


//
//		renderer.setSeriesItemLabelGenerator(0,new StandardCategoryItemLabelGenerator(StandardXYItemLabelGenerator.DEFAULT_ITEM_LABEL_FORMAT,
//				format, format));
//		renderer.setSeriesItemLabelsVisible(0, true);

		//테두리 없음
		localSpiderWebPlot.setOutlineVisible(false);

		//기준선 범례없애기
		LegendItemCollection legendItemsOld = localSpiderWebPlot.getLegendItems();
		final LegendItemCollection legendItemsNew = new LegendItemCollection();

		for(int i = 0; i< legendItemsOld.getItemCount(); i++)
        {
			if(!(i== 0))
            {
				legendItemsNew.add(legendItemsOld.get(i));
			}
		}
		LegendItemSource source = new LegendItemSource()
        {
			final LegendItemCollection lic = new LegendItemCollection();
			{lic.addAll(legendItemsNew);}
			public LegendItemCollection getLegendItems()
            {
				return lic;
			}
		};

		LegendTitle localLegendTitle = new LegendTitle(source);
		localLegendTitle.setPosition(RectangleEdge.RIGHT);
		localLegendTitle.setItemFont(new Font(FONT_NAME, 0, 11));
		localJFreeChart.addSubtitle(localLegendTitle);

		return localJFreeChart;
	}

	// 분포도
	private JFreeChart createChart5(XYDataset paramXYDataset, double avg, double avg_per, double myScore, int height)
    {
		JFreeChart localJFreeChart = ChartFactory.createXYLineChart( null, "점수", "인원", paramXYDataset, PlotOrientation.VERTICAL, false, true, false);
		_theme.apply(localJFreeChart);
	    XYPlot localXYPlot = (XYPlot)localJFreeChart.getPlot();
	    localXYPlot.setBackgroundPaint(Color.WHITE);
	    localXYPlot.setDomainPannable(true);
	    localXYPlot.setRangePannable(true);
	    localXYPlot.setDomainGridlinesVisible(true);
		localXYPlot.setDomainGridlinePaint(gray);
		localXYPlot.setRangeGridlinesVisible(true);
		localXYPlot.setRangeGridlinePaint(gray);

	    ValueAxis localValueAxis1 = localXYPlot.getDomainAxis(); //x축.
	    ValueAxis localValueAxis2 = localXYPlot.getRangeAxis();  //y축.

	    localValueAxis1.setLowerMargin(0.0D);
	    localValueAxis1.setUpperMargin(0.0D);
	    localValueAxis1.setRange(0D, 100.0D);

	    // y축.. 제한 없이간다.
//	    ValueAxis localValueAxis2 = localXYPlot.getRangeAxis();
//	    localValueAxis2.setRange(0.0D, 100.0D);

//	    if(myScore > -1d)

        {
	    	TextAnchor LabelTextanchor = TextAnchor.TOP_LEFT;
	    	RectangleAnchor LabelRectangleAnchor = RectangleAnchor.TOP_RIGHT;
	    	float markerStroke = 2.0f;

	    	if(myScore > 50.0d)
            {
	    		LabelTextanchor = TextAnchor.TOP_RIGHT;
	    		LabelRectangleAnchor = RectangleAnchor.TOP_LEFT;
	    	}
	    	if((myScore >= 0 && myScore < 0.5) || (myScore <= 100 && myScore > 95.5))
            {
	    		markerStroke = 4.0f;
	    	}

	    	localXYPlot.getDomainAxis().setUpperMargin(0.20d);

			ValueMarker localValueMarker1 = new ValueMarker(myScore);
			localValueMarker1.setLabelOffsetType(LengthAdjustmentType.EXPAND);
			localValueMarker1.setPaint(Color.RED);
			localValueMarker1.setStroke(new BasicStroke(markerStroke));
			localValueMarker1.setLabel("나의점수");
			localValueMarker1.setLabelOffset(new RectangleInsets(3.0d, 5.0d, 3.0d, 5.0d));
			localValueMarker1.setLabelFont(new Font(FONT_NAME, Font.BOLD, 12));
			localValueMarker1.setLabelPaint(red);
			localValueMarker1.setLabelAnchor(LabelRectangleAnchor);
			localValueMarker1.setLabelTextAnchor(LabelTextanchor);
			localXYPlot.addDomainMarker(localValueMarker1);
		}


        {
	    	CircleDrawer localCircleDrawer = new CircleDrawer(new Color(9,166,14), new BasicStroke(1.0F), new Color(9,200,19));
		    XYDrawableAnnotation localXYDrawableAnnotation = new XYDrawableAnnotation(avg, avg_per, 11.0D, 11.0D, localCircleDrawer);
		    localXYPlot.addAnnotation(localXYDrawableAnnotation);

		    double maxRangeValue = localValueAxis2.getUpperBound();
		    double textYOffset = Math.round(( 12.0d / height * maxRangeValue) * Math.pow(10, 2)) / Math.pow(10, 2);
		    XYTextAnnotation localXYTextAnnotation = new XYTextAnnotation("평균",avg, avg_per + textYOffset);
		    localXYTextAnnotation.setFont(new Font(FONT_NAME, Font.BOLD, 13));
		    localXYTextAnnotation.setTextAnchor(TextAnchor.BASELINE_CENTER);
		    localXYPlot.addAnnotation(localXYTextAnnotation);
	    }

	    XYItemRenderer localXYItemRenderer = localXYPlot.getRenderer();
	    localXYItemRenderer.setSeriesPaint(0, new Color(60, 96, 240));

	    return localJFreeChart;
	}

	// 정규 표준 편차 그래프.
	private JFreeChart createChart6(XYSeriesCollection paramXYSeriesCollection, ArrayList<HashMap<String, Object>> gradeValues, int height)
    {
		JFreeChart localJFreeChart = ChartFactory.createXYLineChart("",
				"", "", paramXYSeriesCollection, PlotOrientation.VERTICAL, true,
				false, false);
		_theme.apply(localJFreeChart);
		XYPlot localXYPlot = (XYPlot)localJFreeChart.getPlot();
		localXYPlot.setBackgroundPaint(white);
	    localXYPlot.setDomainPannable(true);
	    localXYPlot.setRangePannable(true);

	    ValueAxis localValueAxis1 = localXYPlot.getRangeAxis();
	    ValueAxis localValueAxis2 = localXYPlot.getDomainAxis();
	    localValueAxis1.setVisible(false);
	    localValueAxis1.setLowerBound(-0.002);
	    DecimalFormat decimal = new DecimalFormat(".###");

	    double maxRangeValue = localValueAxis1.getUpperBound();
	    double upperBoundValue = maxRangeValue + (Double.parseDouble(decimal.format(maxRangeValue)) * 70 / height);

	    localValueAxis1.setUpperBound(upperBoundValue);
	    localValueAxis2.setUpperMargin(0.0d);

	    XYSplineRenderer localXYSplineRenderer = new XYSplineRenderer();
	    localXYSplineRenderer.setSeriesVisibleInLegend(0, false);

	    ArrayList<Color> gradeAreaColor = new ArrayList<Color>();
	    gradeAreaColor.add(new Color(23, 179, 62, 10));
	    gradeAreaColor.add(new Color(26, 128, 187, 10));
	    gradeAreaColor.add(new Color(252, 129, 49, 10));
	    gradeAreaColor.add(new Color(250, 236, 30, 10));
	    gradeAreaColor.add(new Color(221, 30, 250, 10));

	    int colorIdx = 0;
	    double valueLabelYPosition = Double.parseDouble(decimal.format(maxRangeValue)) * 30 / height;
	    for (HashMap<String, Object> data : gradeValues)
        {
	    	String gradeLabel = data.get("gradeLabel").toString();
	    	String valueLabel = data.get("valueLabel").toString();

	    	ArrayList<Double> values = (ArrayList<Double>) data.get("values");

	    	double start = values.get(0);
	    	double end = values.get(1);

	    	Marker gradeArea = new IntervalMarker(start, end);
	    	gradeArea.setPaint(gradeAreaColor.get(colorIdx));
	    	gradeArea.setLabel(gradeLabel);
	    	gradeArea.setLabelAnchor(RectangleAnchor.TOP);
	    	gradeArea.setLabelTextAnchor(TextAnchor.TOP_CENTER);
	    	gradeArea.setLabelOffsetType(LengthAdjustmentType.CONTRACT);

	    	Font font = new Font(FONT_NAME, Font.BOLD, 11);
	    	gradeArea.setLabelFont(font);
	    	localXYPlot.addDomainMarker(gradeArea, Layer.BACKGROUND);

	    	XYTextAnnotation localXYTextAnnotation = new XYTextAnnotation(valueLabel, start + (end - start) * 0.5, valueLabelYPosition);
	    	localXYTextAnnotation.setTextAnchor(TextAnchor.TOP_CENTER);
			localXYPlot.addAnnotation(localXYTextAnnotation);

	    	colorIdx++;
	    }

		localXYPlot.setRenderer(0, localXYSplineRenderer);
		return localJFreeChart;
	}

	// 꺽은선 그래프 학습역량분석
	private JFreeChart createChart7(XYDataset paramXYDataset, String text, double textXPosition,
                                    double textYPosition, TextAnchor textAnchor)
    {

		JFreeChart localJFreeChart = ChartFactory.createXYLineChart(null, "학력지수", "역량지수", paramXYDataset, PlotOrientation.VERTICAL, false, true, false);
		_theme.apply(localJFreeChart);
		final XYPlot localXYPlot = (XYPlot)localJFreeChart.getPlot();
		localXYPlot.setDomainGridlinesVisible(true);
		localXYPlot.setDomainGridlinePaint(gray);
		localXYPlot.setRangeGridlinesVisible(true);
		localXYPlot.setRangeGridlinePaint(gray);
	    localXYPlot.setBackgroundPaint(Color.WHITE);
	    localXYPlot.setDomainPannable(true);
	    localXYPlot.setRangePannable(true);

	    ValueAxis localValueAxis1 = localXYPlot.getDomainAxis();
	    ValueAxis localValueAxis2 = localXYPlot.getRangeAxis();

	    localValueAxis1.setRange(0D, 100.0D);
	    localValueAxis2.setRange(0D, 100.0D);
	    localValueAxis1.setUpperBound(120.0D);
	    localValueAxis2.setUpperBound(120.0D);

	    final String localText = text;
	    XYLineAndShapeRenderer localXYLineAndShapeRenderer =  new XYLineAndShapeRenderer(true, true)
        {
	        final Shape baseTriangle = ShapeUtilities.createUpTriangle(2.0f);
	        final double diagonalAngle = Math.toRadians(45.0d);
	        final double rightAngle = Math.toRadians(90.0d);

	        final Shape diagonalTriangle = ShapeUtilities.rotateShape(baseTriangle, diagonalAngle, 0, 0);
	        final Shape rightTriangle = ShapeUtilities.rotateShape(baseTriangle, rightAngle, 0, 0);

	        @Override
	        public Shape getItemShape(int row, int column)
            {
	            Shape resultShape = ShapeUtilities.createDiamond(0);

	            if (row == 1)
                {
		            if (localText.equals("발전학습"))
                    {	// 발전학습
		            	if (column == 0)
                        {
		            		//resultShape = baseDiamond;
		            	} else
                        {
		            		resultShape = diagonalTriangle;
		            	}
		            } else if (localText.equals("개념학습"))
                    { // 개념학습
		            	if (column == 0)
                        {
		            		//resultShape = baseDiamond;
		            	} else if (column == 1)
                        {
		            		resultShape = rightTriangle;
		            	} else
                        {
		            		resultShape = diagonalTriangle;
		            	}
		            } else
                    { // 사고력 훈련
		            	if (column == 0)
                        {
		            		//resultShape = baseDiamond;
		            	} else if (column == 1)
                        {
		            		resultShape = baseTriangle;
		            	} else
                        {
		            		resultShape = diagonalTriangle;
		            	}
		            }
	            }

	            return resultShape;
	        }
	    };

	    // 나의 위치 이미지 포지션
	    double xPoint1 = paramXYDataset.getXValue(1, 0);
	    double yPoint1 = paramXYDataset.getYValue(1, 0) - 5.0d;
	    // 값이 작아서 이미지가 짤리는 경우 보정.
	    xPoint1 = (xPoint1 < 8)? 8  : xPoint1;
	    yPoint1 = (yPoint1 < 8)? 20 : yPoint1;

//	    Image rootImage = resManager.ico_person;
//	    ImageIcon resizeImageIcon = new ImageIcon(rootImage.getScaledInstance(15, 15, java.awt.Image.SCALE_SMOOTH));
//	    Image resizeImage = resizeImageIcon.getImage();
	    
	    // 나의 위치 이미지 랜더링.
//	    XYImageAnnotation localXYImageAnnotation = new XYImageAnnotation(xPoint1, yPoint1, resizeImage);
//	    localXYPlot.addAnnotation(localXYImageAnnotation);
	    
	    // 등급 구간 및 구간별 백분율 
	    XYTextAnnotation localXYTextAnnotation = new XYTextAnnotation(localText, textXPosition, textYPosition);
	    localXYTextAnnotation.setTextAnchor(textAnchor);
	    localXYTextAnnotation.setBackgroundPaint(new Color(9,200,19));
	    localXYTextAnnotation.setPaint(white);
	    localXYTextAnnotation.setFont(new Font(FONT_NAME, Font.BOLD, 11));
	    localXYTextAnnotation.setOutlineStroke(new BasicStroke(2.0F));
	    localXYTextAnnotation.setOutlinePaint(new Color(9,166,14));	    
	    localXYPlot.addAnnotation(localXYTextAnnotation);
	   
	    localXYLineAndShapeRenderer.setSeriesShapesVisible(1, true);	    
	    localXYPlot.setRenderer(localXYLineAndShapeRenderer);	   
	    
	    return localJFreeChart;
	}
	
	
	// 일반 막대그래프 - 막대간 y value 차이 표시.
	private JFreeChart createChart8(IntervalXYDataset paramIntervalXYDataset, XYSeries distance, Boolean isInvert, String title1, String title2)
    {
		JFreeChart localJFreeChart = ChartFactory.createXYBarChart(null, null, false, null, paramIntervalXYDataset, PlotOrientation.VERTICAL, false, false, false);
		_theme.apply(localJFreeChart);

		XYPlot localXYPlot = (XYPlot) localJFreeChart.getPlot();
		localXYPlot.setBackgroundPaint(Color.WHITE);
		localXYPlot.setRangePannable(true);
		localXYPlot.setRangeZeroBaselineVisible(true);
		localXYPlot.setDomainGridlinesVisible(false);		
		localXYPlot.setDomainGridlinePaint(gray);
		localXYPlot.setRangeGridlinesVisible(true);
		localXYPlot.setRangeGridlinePaint(gray);
		localXYPlot.getRangeAxis().setInverted(isInvert);	
		localXYPlot.setRangeZeroBaselineVisible(false);
		
		NumberAxis localNumberAxisX = (NumberAxis) localXYPlot.getDomainAxis();
		NumberAxis localNumberAxisY = (NumberAxis) localXYPlot.getRangeAxis();
		localNumberAxisX.setVisible(false);
		localNumberAxisX.setRange(0, 10.0d);
		localNumberAxisY.setRange(0, 100.0d);
		localNumberAxisY.setUpperMargin(0.15D);
		localNumberAxisY.setLowerMargin(-0.15D);
		localNumberAxisY.setUpperBound(115.0d);
		localNumberAxisY.setLowerBound(-15.0d);

		GradientPaint localGradientPaint1 = new GradientPaint(0.0f, 0.0f, new Color(60, 96, 240),   0.0f, 0.0f, new Color(104, 146, 252));
		XYBarRenderer localXYBarRenderer = new XYBarRenderer();
		localXYBarRenderer.setSeriesVisible(1, false);
		localXYBarRenderer.setShadowVisible(false);	
		localXYBarRenderer.setBarPainter(new StandardXYBarPainter());
		localXYBarRenderer.setSeriesPaint(0, localGradientPaint1);			
		localXYBarRenderer.setSeriesOutlinePaint(0, blue);
		localXYBarRenderer.setBaseItemLabelsVisible(true);
		localXYBarRenderer.setBaseItemLabelGenerator(new StandardXYItemLabelGenerator());
		
		// 백분율 차이 그리기 관련 좌표.
	    final double xPoint1 = UnitUtil.toDouble(distance.getX(0)) + 0.8d; // 나의백분율 x  
	    final double xPoint2 = UnitUtil.toDouble(distance.getX(1)); // 나의백분율 y
	    final double xPoint3 = UnitUtil.toDouble(distance.getX(2)) - 0.8d; // 백분율차이 중간값 x
	    final double yPoint1 = UnitUtil.toDouble(distance.getY(0)); // 백분율차이 중간값 y
	    final double yPoint2 = UnitUtil.toDouble(distance.getY(1)); // 목표백분율 x
	    final double yPoint3 = UnitUtil.toDouble(distance.getY(2)); // 목표백분율 y
	    
	    XYLineAnnotation line1 = new XYLineAnnotation(xPoint1, yPoint1, xPoint2, yPoint2);
	    XYLineAnnotation line2 = new XYLineAnnotation(xPoint2, yPoint2, xPoint3, yPoint3)
        {
	    	
			private static final long serialVersionUID = -3310626735836143018L;

			@Override
	    	public void draw(Graphics2D g2, XYPlot plot, Rectangle2D dataArea, ValueAxis domainAxis, ValueAxis rangeAxis, int rendererIndex, PlotRenderingInfo info)
            {
				
				super.draw(g2, plot, dataArea, domainAxis, rangeAxis, rendererIndex, info);

				double valueY3 = plot.getRangeAxis().valueToJava2D(yPoint3, dataArea, plot.getRangeAxisEdge());
				double valueX3 = plot.getDomainAxis().valueToJava2D(xPoint3, dataArea, plot.getDomainAxisEdge());

				double valueY2 = plot.getRangeAxis().valueToJava2D(yPoint2, dataArea, plot.getRangeAxisEdge());
				double valueX2 = plot.getDomainAxis().valueToJava2D(xPoint2, dataArea, plot.getDomainAxisEdge());
				
	    		double angle;
	    		double revisionAngle = Math.toRadians(-90.0d);
	    	    angle = Math.atan2(valueY3-valueY2,valueX3-valueX2) + revisionAngle;
	    	   	    	    
	    	    Polygon arrowPolygon = new Polygon();
	    	    arrowPolygon.addPoint( 0, 5);
	    	    arrowPolygon.addPoint( -5, -5);
	    	    arrowPolygon.addPoint( 5,-5);
	    	    arrowPolygon.translate((int)valueX3, (int)valueY3);
	    	  
	    	    Shape arrowShape1 = ShapeUtilities.rotateShape(arrowPolygon, angle, (int)valueX3, (int)valueY3);
	    	    
	    	   	g2.setStroke(new BasicStroke(1.0f));
	    	   	g2.setColor(Color.BLACK);
	    	   	g2.fill(arrowShape1);
	    	   	g2.setPaint(Color.BLACK);
	    	    g2.draw(arrowShape1);
	    	}
	    };

	    localXYPlot.addAnnotation(line1);
	    localXYPlot.addAnnotation(line2);

	    
		// 나의 백분율 & 목표 배분율 차이.
		CircleDrawer localCircleDrawer = new CircleDrawer(new Color(9,166,14), new BasicStroke(1.0F), new Color(9,200,19));		    
		XYDrawableAnnotation localXYDrawableAnnotation = new XYDrawableAnnotation(xPoint2, yPoint2, 35.0D, 35.0D, localCircleDrawer);			
		localXYPlot.addAnnotation(localXYDrawableAnnotation);
		
		XYTextAnnotation distanceText = new XYTextAnnotation(distance.getDescription(), xPoint2, yPoint2);		
		distanceText.setFont(new Font(FONT_NAME, 0, 12));
		distanceText.setTextAnchor(TextAnchor.CENTER);
		localXYPlot.addAnnotation(distanceText);
		
		double labelYPosition = -7.5d;
		
		// y axis의 value 가 위에서 부터 0일때 
		if(isInvert)
        {
			localXYBarRenderer.setBase(100);
			labelYPosition = 107.5d;
		}
		
		// 나의 백분율 label		
		XYTextAnnotation text1 = new XYTextAnnotation(title1, 2.0d , labelYPosition);
		text1.setFont(new Font(FONT_NAME, 0, 11));
		text1.setTextAnchor(TextAnchor.CENTER);
		localXYPlot.addAnnotation(text1);
		
		// 목표 백분율 label		
		XYTextAnnotation text2 = new XYTextAnnotation(title2, 8.0d , labelYPosition);
		text2.setFont(new Font(FONT_NAME, 0, 11));
		text2.setTextAnchor(TextAnchor.CENTER);
		localXYPlot.addAnnotation(text2);
		
		localXYPlot.setRenderer(0, localXYBarRenderer);		
		
		return localJFreeChart;
	}


	// 일반 막대그래프 + 꺾은선 그래프
	private JFreeChart createChartBarLine(DefaultCategoryDataset dataset1,DefaultCategoryDataset dataset2)
    {
		final CategoryPlot plot = new CategoryPlot();

		plot.setBackgroundPaint(Color.WHITE);
		plot.setDomainAxis(new CategoryAxis());

		final NumberAxis yAxis = new NumberAxis();
		//Y축 최소,최대값
		yAxis.setRange(0.00,100.00);

		//그리드간격
		NumberTickUnit ntu = new NumberTickUnit(10, new DecimalFormat("0"));
		yAxis.setTickUnit( ntu );

		plot.setRangeAxis(yAxis);
		plot.setOrientation(PlotOrientation.VERTICAL);
		plot.setRangeGridlinesVisible(true);
		plot.setDomainGridlinesVisible(false);
		plot.setRangePannable(true);
		plot.setRangeZeroBaselineVisible(true);
		plot.setDomainGridlinePaint(gray);
		plot.setRangeGridlinePaint(gray);

		final CategoryItemRenderer renderer = new BarRenderer();

		plot.setDataset(dataset1);
		plot.setRenderer(renderer);
		BarRenderer br = (BarRenderer) plot.getRenderer();
		br.setMaximumBarWidth(.08); // set maximum width to 35% of chart
//		br.setItemMargin(-2);
		br.setShadowVisible(false);
		br.setSeriesPaint(0, new Color(34, 63, 101));

		final CategoryItemRenderer renderer2 = new LineAndShapeRenderer();
		plot.setDataset(1, dataset2);
		plot.setRenderer(1, renderer2);

		plot.setDatasetRenderingOrder(DatasetRenderingOrder.FORWARD);

		final JFreeChart localJFreeChart = new JFreeChart(plot);

		//범례표시
		localJFreeChart.setBackgroundPaint(white);
		LegendTitle legend = localJFreeChart.getLegend();
		legend.setPosition(RectangleEdge.RIGHT);
		legend.setItemFont(new Font(FONT_NAME, 0, 11));
		legend.setBorder(0f,0f,0f,0f);

		//막대그래프 위에 value 표시
		NumberFormat format = NumberFormat.getNumberInstance();
		renderer.setSeriesItemLabelGenerator(0,new StandardCategoryItemLabelGenerator(StandardXYItemLabelGenerator.DEFAULT_ITEM_LABEL_FORMAT,
						format, format));
		renderer.setSeriesItemLabelsVisible(0, true);


		return localJFreeChart;
	}

	// multi y axis
	private JFreeChart createChartMultiAxis(DbList list) {
		final XYPlot plot = new XYPlot();
		int index = 0;

		for (DbMap x : list) {
			XYSeriesCollection dataset = (XYSeriesCollection) x.get("dataset");

			plot.setDataset(index, dataset);
			++index;

		}


		//customize the plot with renderers and axis
		plot.setRenderer(0, new XYSplineRenderer());//use default fill paint for first series
		XYSplineRenderer splinerenderer = new XYSplineRenderer();
		splinerenderer.setSeriesFillPaint(0, Color.BLUE);
		plot.setRenderer(1, splinerenderer);

		XYSplineRenderer splinerenderer2 = new XYSplineRenderer();
		splinerenderer2.setSeriesFillPaint(0, Color.ORANGE);
		plot.setRenderer(2, splinerenderer2);

		plot.setDomainAxis(new NumberAxis("X Axis"));

		for (int i = 0; i < list.size(); i++) {

			String name = null;
			if (i == 0) name = "온도";
			if (i == 1) name = "습도";
			if (i == 2) name = "CO2";


			plot.setRangeAxis(i, new NumberAxis(name));

			plot.mapDatasetToRangeAxis(i, 0);
		}




		final JFreeChart localJFreeChart = new JFreeChart(plot);


		return localJFreeChart;
	}




	// multi y axis time multi series
	private JFreeChart createChartMultiAxisTime(DbList list) {
		final XYPlot plot = new XYPlot();
		int index = 0;

		for (DbMap x : list) {
			XYSeriesCollection dataset = (XYSeriesCollection) x.get("dataset");

			plot.setDataset(index, dataset);
			double min = dataset.getRangeLowerBound(false);
			double max = dataset.getRangeUpperBound(false);
			x.put("min",min);
			x.put("max",max);
			++index;
//			double min = dataset.getMinRegularValue("0", "").doubleValue(); //$NON-NLS-1$ //$NON-NLS-2$
//			double max = dataset.getMaxRegularValue("0", "").doubleValue(); //$NON-NLS-1$ //$NON-NLS-2$

		}

        XYSplineRenderer splinerenderer = new XYSplineRenderer();
        splinerenderer.setSeriesFillPaint(0, Color.BLUE);
		plot.setRenderer(0, splinerenderer);


        //온도
        XYSplineRenderer splinerenderer1 = new XYSplineRenderer();
        splinerenderer1.setSeriesFillPaint(0, Color.RED);
        plot.setRenderer(1, splinerenderer1);
        plot.setRangeAxisLocation(0, AxisLocation.BOTTOM_OR_LEFT);
        plot.setRangeAxisLocation(1, AxisLocation.BOTTOM_OR_LEFT);

        plot.setRangeAxisLocation(2, AxisLocation.BOTTOM_OR_RIGHT);
        plot.setRangeAxisLocation(3, AxisLocation.BOTTOM_OR_RIGHT);

        //
        XYSplineRenderer splinerenderer2 = new XYSplineRenderer();
        splinerenderer2.setSeriesFillPaint(0, Color.BLACK);
        plot.setRenderer(2, splinerenderer2);

        XYSplineRenderer splinerenderer3 = new XYSplineRenderer();
        splinerenderer3.setSeriesFillPaint(0, Color.GREEN);
        plot.setRenderer(3, splinerenderer3);




		//x axis
		plot.setDomainAxis(new NumberAxis("시간"));
		NumberAxis domain = (NumberAxis) plot.getDomainAxis();
		domain.setRange(0.00, 24.00);
		domain.setTickUnit(new NumberTickUnit(1));




//		DateAxis domainAxis = new DateAxis("Date");
//		plot.setDomainAxis(domainAxis);


//		final DateAxis axis = (DateAxis) plot.getDomainAxis();
//		axis.setDateFormatOverride(new SimpleDateFormat("hh:mma"));
//		axis.setDateFormatOverride(new SimpleDateFormat("hh"));

        int listSize = list.size();
        logger.info("listSize={}",listSize);
		for (int i = 0; i < list.size(); i++) {

			String name = null;
			if(listSize==3){
				if (i == 0) name = "도온";
				if (i == 1) name = "도습";
				if (i == 2) name = "CO2";
			}else if(listSize==2){
				if (i == 0) name = "풍속";
				if (i == 1) name = "일사량";

			}else if(listSize==4){
				if (i == 0) name = "도온";
				if (i == 1) name = "도습";
				if (i == 2) name = "일사량";
				if (i == 3) name = "풍속";
			}

			plot.setRangeAxis(i, new NumberAxis(name));



			plot.mapDatasetToRangeAxis(i, i);

            NumberAxis range = (NumberAxis) plot.getRangeAxis(i);
//            range.setRange(0, 10);
//            range.setTickUnit(new NumberTickUnit(1));

//			double min = UnitUtil.toDouble(list.get(i).get("min"));
			double min= 0;
			double max = UnitUtil.toDouble(list.get(i).get("max"));

			double unit = (max - min) / 10;
			unit = UnitUtil.round(unit,0);
			range.setRange(0, max +5);
			range.setTickUnit(new NumberTickUnit(unit));


            if (i == 0 || i == 1) {
                range.setLabelAngle(Math.PI *2);
            }


        }



		final JFreeChart localJFreeChart = new JFreeChart(plot);


		return localJFreeChart;
	}
}
