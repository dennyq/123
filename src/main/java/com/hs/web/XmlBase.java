package com.hs.web;

import com.google.gson.Gson;
import com.hs.util.HttpUtil;
import com.hs.util.UnitUtil;
import com.hs.BizException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;
import java.io.IOException;
import java.io.StringReader;
import java.util.Map;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

/**
 * Created by eks on 2015-05-14.
 */
public abstract class XmlBase {
  private final static Logger logger = LoggerFactory.getLogger(XmlBase.class);
  private XPath _xpath;
  private Gson _gson;
  public XmlBase() throws SAXException, IOException, ParserConfigurationException {
    _xpath = XPathFactory.newInstance().newXPath();
    _gson = new Gson();
  }

  public abstract void execute(RequestMap req) throws Exception;

  protected Map<String, Object> newJsonMap(String url) throws IOException {
    String json = HttpUtil.downloadString(url);
    if (json.length() == 0)
      throw new BizException("서버에서 잘못된 데이타를 반환했습니다.");

    if (json.charAt(0) == '(') {
      json = json.substring(1, json.length() - 1);
    }
    Map<String, Object> map = _gson.fromJson(json, Map.class);
    if (map.get("error") != null) {
      Map<String, Object> error = cast(map.get("error"));
      String msg = String.format("Server Error = [%s] %s", error.get("code"), error.get("message"));
      throw new IOException(msg);
    }
    return map;
  }

  protected Document newDocument(String url) throws SAXException, IOException, ParserConfigurationException {
    String xml = HttpUtil.downloadString(url);

    InputSource is = new InputSource(new StringReader(xml));

    Document document = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(is);

    return document;
  }

  protected NodeList getNodeList(String expression, Object document) throws XPathExpressionException {
    return (NodeList)_xpath.evaluate(expression, document, XPathConstants.NODESET);
  }



  protected Node getNode(String expression, Object document) throws XPathExpressionException {
    return (Node)_xpath.evaluate(expression, document, XPathConstants.NODE);
  }

  protected String getString(String expression, Object document) throws XPathExpressionException {
    return (String)_xpath.evaluate(expression, document, XPathConstants.STRING);
  }

  protected double getNumber(String expression, Object document) throws XPathExpressionException {
    return Double.parseDouble(_xpath.evaluate(expression, document, XPathConstants.NUMBER)+"");
  }

  public <T> T cast(Object obj) {
    return UnitUtil.cast(obj);
  }
}
