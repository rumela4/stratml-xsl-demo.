<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html" indent="yes" encoding="UTF-8"/>

  <xsl:template match="/">
    <html lang="en">
      <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <title>
          <xsl:choose>
            <xsl:when test="/*/*[local-name()='Name']">
              <xsl:value-of select="/*/*[local-name()='Name'][1]"/>
            </xsl:when>
            <xsl:otherwise>StratML Document</xsl:otherwise>
          </xsl:choose>
        </title>
        <style>
          :root { --bg:#f7f8fa; --card:#ffffff; --text:#1d2733; --muted:#5b6b7c; --accent:#2f7de1; --ok:#2eae5f; --warn:#e67e22; --bad:#e74c3c; --border:#e5e9f0; }
          @media (prefers-color-scheme: dark) { :root { --bg:#0f141a; --card:#121922; --text:#e8eef7; --muted:#9fb0c3; --accent:#6aa8ff; --border:#222c3a; } }
          *{box-sizing:border-box} html,body{margin:0;padding:0}
          body{font-family:system-ui,-apple-system,Segoe UI,Roboto,Ubuntu; background:var(--bg); color:var(--text); line-height:1.6}
          .wrapper{max-width:1100px;margin:0 auto;padding:24px}
          .header{display:flex;gap:16px;align-items:center;margin-bottom:16px}
          .logo{width:56px;height:56px;border-radius:12px;background:var(--card);border:1px solid var(--border);display:flex;align-items:center;justify-content:center;font-weight:700}
          .title h1{margin:0;font-size:28px}
          .muted{color:var(--muted)}
          .grid{display:grid;grid-template-columns:280px 1fr;gap:20px}
          @media (max-width: 960px){ .grid{display:block} }
          .toc{position:sticky; top:12px; align-self:start; background:var(--card); border:1px solid var(--border); border-radius:14px; padding:14px}
          .toc h3{margin:0 0 8px 0;font-size:16px}
          details>summary{cursor:pointer; padding:6px 8px; border-radius:8px; }
          details{border:1px dashed var(--border); border-radius:10px; padding:6px; margin:6px 0}
          .card{background:var(--card); border:1px solid var(--border); border-radius:16px; padding:16px; margin-bottom:16px}
          h2{margin:0 0 8px 0} h3{margin:6px 0}
          .kvs{display:grid; grid-template-columns:repeat(auto-fit,minmax(220px,1fr)); gap:10px; margin-top:8px}
          .kv{border:1px solid var(--border); border-radius:12px; padding:10px}
          .goal{border-left:5px solid var(--accent); padding-left:12px; margin:10px 0}
          .objective{border-left:5px solid var(--ok); padding-left:12px; margin:10px 0}
          .pi{border:1px solid var(--border); border-radius:12px; padding:10px; margin:10px 0; background:linear-gradient(180deg, rgba(0,0,0,0.02), transparent)}
          .pi h4{margin:0 0 6px 0}
          .bar{height:12px; background:#d7dee8; border-radius:8px; overflow:hidden}
          .bar>span{display:block; height:100%; text-align:right; padding-right:6px; color:#fff; font-size:11px; line-height:12px}
          .ok{background:linear-gradient(90deg, var(--ok), #65d38f)}
          .bad{background:linear-gradient(90deg, var(--bad), #f09c9c)}
          .warn{background:linear-gradient(90deg, var(--warn), #f4b07a)}
          .flex{display:flex; gap:8px; align-items:center; flex-wrap:wrap}
          .chip{border:1px solid var(--border); border-radius:999px; padding:2px 8px; font-size:12px}
          table{width:100%; border-collapse:collapse; margin-top:8px}
          th,td{border:1px solid var(--border); padding:6px 8px; text-align:left}
          th{background:rgba(0,0,0,0.03)} .mini{font-size:12px}
          .canvasWrap{width:100%; max-width:560px; margin-top:8px} .note{font-size:12px; color:var(--muted)}
        </style>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
      </head>
      <body>
        <div class="wrapper">
          <div class="header" role="banner" aria-label="Document Header">
            <div class="logo" aria-hidden="true">📄</div>
            <div class="title">
              <h1>
                <xsl:choose>
                  <xsl:when test="/*/*[local-name()='Name']">
                    <xsl:value-of select="/*/*[local-name()='Name'][1]"/>
                  </xsl:when>
                  <xsl:otherwise>StratML Document</xsl:otherwise>
                </xsl:choose>
              </h1>
              <div class="muted mini"><xsl:value-of select="normalize-space(/*/*[local-name()='Description'][1])"/></div>
            </div>
          </div>
          <div class="grid">
            <nav class="toc" role="navigation" aria-label="Table of Contents">
              <h3>Contents</h3>
              <details open="open"><summary>Goals</summary>
                <ol class="mini">
                  <xsl:for-each select="//*[local-name()='Goals']/*[local-name()='Goal']">
                    <li><a href="#g-{position()}"><xsl:value-of select="normalize-space(*[local-name()='Name'][1])"/></a></li>
                  </xsl:for-each>
                </ol>
              </details>
              <details><summary>Objectives</summary>
                <ol class="mini">
                  <xsl:for-each select="//*[local-name()='Objectives']/*[local-name()='Objective']">
                    <li><a href="#o-{position()}"><xsl:value-of select="normalize-space(*[local-name()='Name'][1])"/></a></li>
                  </xsl:for-each>
                </ol>
              </details>
              <details><summary>Values</summary>
                <ul class="mini">
                  <xsl:for-each select="//*[local-name()='Values']/*"><li><xsl:value-of select="."/></li></xsl:for-each>
                </ul>
              </details>
              <div class="note">Tip: Click to expand/collapse long lists.</div>
            </nav>
            <main>
              <div class="card" role="region" aria-label="Key Fields">
                <div class="kvs">
                  <xsl:if test="/*/*[local-name()='StartDate']"><div class="kv"><strong>Start:</strong> <xsl:value-of select="/*/*[local-name()='StartDate'][1]"/></div></xsl:if>
                  <xsl:if test="/*/*[local-name()='EndDate']"><div class="kv"><strong>End:</strong> <xsl:value-of select="/*/*[local-name()='EndDate'][1]"/></div></xsl:if>
                  <xsl:if test="/*/*[local-name()='Issuer']/*[local-name()='Name']"><div class="kv"><strong>Issuer:</strong> <xsl:value-of select="/*/*[local-name()='Issuer']/*[local-name()='Name'][1]"/></div></xsl:if>
                  <xsl:if test="//*[local-name()='Stakeholders']/*/*[local-name()='Name']"><div class="kv"><strong>Stakeholders:</strong> <xsl:value-of select="count(//*[local-name()='Stakeholders']/*)"/></div></xsl:if>
                </div>
              </div>
              <div class="card">
                <h2>Goals</h2>
                <xsl:for-each select="//*[local-name()='Goals']/*[local-name()='Goal']">
                  <div class="goal" id="g-{position()}">
                    <h3><xsl:value-of select="normalize-space(*[local-name()='Name'][1])"/></h3>
                    <div class="muted"><xsl:value-of select="normalize-space(*[local-name()='Description'][1])"/></div>
                    <xsl:for-each select=".//*[local-name()='Objectives']/*[local-name()='Objective']">
                      <div class="objective" id="o-{position()}">
                        <h4><xsl:value-of select="normalize-space(*[local-name()='Name'][1])"/></h4>
                        <div class="muted"><xsl:value-of select="normalize-space(*[local-name()='Description'][1])"/></div>
                        <xsl:apply-templates select=".//*[local-name()='PerformanceIndicators']/*[local-name()='PerformanceIndicator']"/>
                      </div>
                    </xsl:for-each>
                  </div>
                </xsl:for-each>
              </div>
            </main>
          </div>
        </div>
        <script><![CDATA[
          (function(){
            function parseSeries(node){
              try { return JSON.parse(node.getAttribute('data-series')||'[]'); } catch(e){ return []; }
            }
            function colorFor(actual, target){
              if(target==null || isNaN(target)) return 'warn';
              if(actual>=target) return 'ok';
              if(target-actual <= target*0.1) return 'warn'; // within 10%
              return 'bad';
            }
            function renderBar(container){
              var actual = parseFloat(container.getAttribute('data-actual'));
              var target = parseFloat(container.getAttribute('data-target'));
              if(isNaN(actual)) return;
              var pct = Math.max(0, Math.min(100, actual));
              var cls = colorFor(actual, target);
              var bar = container.querySelector('.bar>span');
              bar.style.width = pct + '%';
              bar.className = bar.className + ' ' + cls;
              bar.textContent = (isNaN(actual)?'':actual + '%');
            }
            function renderChart(canvas){
              if(!window.Chart) return;
              var series = parseSeries(canvas);
              if(!series.length) return;
              var ctx = canvas.getContext('2d');
              var labels = series.map(function(p){ return p.t || ''; });
              var actual = series.map(function(p){ return p.a; });
              var target = series.map(function(p){ return p.g; });
              new Chart(ctx, {
                type: 'line',
                data: {
                  labels: labels,
                  datasets: [{
                    label: 'Actual', data: actual, tension: 0.25
                  },{
                    label: 'Target', data: target, borderDash: [6,6], tension: 0.1
                  }]
                },
                options: {
                  responsive:true, maintainAspectRatio:false,
                  plugins:{ legend:{ display:true } },
                  scales:{ x:{ ticks:{ autoSkip:true } }, y:{ beginAtZero:true } }
                }
              });
            }
            document.querySelectorAll('.pi[data-actual]').forEach(renderBar);
            document.querySelectorAll('canvas[data-series]').forEach(renderChart);
          })();
        ]]></script>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="*[local-name()='PerformanceIndicator']">
    <xsl:variable name="target" select="number(*[local-name()='Target']/*[local-name()='MeasureValue'][1])"/>
    <xsl:variable name="actual" select="number((*[local-name()='Current']/*[local-name()='MeasureValue'] | *[local-name()='Actual']/*[local-name()='MeasureValue'])[1])"/>
    <div class="pi" role="group">
      <xsl:attribute name="data-target"><xsl:value-of select="$target"/></xsl:attribute>
      <xsl:attribute name="data-actual"><xsl:value-of select="$actual"/></xsl:attribute>

      <h4><xsl:value-of select="normalize-space(*[local-name()='Name'][1])"/></h4>
      <div class="flex mini">
        <span class="chip">Unit: <xsl:value-of select="normalize-space(*[local-name()='UnitOfMeasure'][1])"/></span>
        <xsl:if test="*[local-name()='Target']/*[local-name()='MeasureValue']"><span class="chip">Target: <xsl:value-of select="normalize-space(*[local-name()='Target']/*[local-name()='MeasureValue'][1])"/></span></xsl:if>
        <xsl:if test="*[local-name()='Current']/*[local-name()='MeasureValue'] or *[local-name()='Actual']/*[local-name()='MeasureValue']"><span class="chip">Actual: <xsl:value-of select="normalize-space((*[local-name()='Current']/*[local-name()='MeasureValue'] | *[local-name()='Actual']/*[local-name()='MeasureValue'])[1])"/></span></xsl:if>
      </div>

      <div class="bar" title="Progress vs target" aria-label="Progress bar"><span class="ok"></span></div>

      <table aria-label="Target vs Actual">
        <thead><tr><th>Type</th><th>Value</th></tr></thead>
        <tbody>
          <tr><td>Target</td><td><xsl:value-of select="normalize-space(*[local-name()='Target']/*[local-name()='MeasureValue'][1])"/></td></tr>
          <tr><td>Actual</td><td><xsl:value-of select="normalize-space((*[local-name()='Current']/*[local-name()='MeasureValue'] | *[local-name()='Actual']/*[local-name()='MeasureValue'])[1])"/></td></tr>
        </tbody>
      </table>

      <xsl:variable name="seriesJSON">
        <xsl:text>[</xsl:text>
        <xsl:for-each select="(*[local-name()='ActualResults']/*[local-name()='Result'] | *[local-name()='Results']/*[local-name()='Result'])">
          <xsl:if test="position() &gt; 1">,<xsl:text/></xsl:if>
          <xsl:text>{"t":"</xsl:text>
          <xsl:value-of select="normalize-space(*[local-name()='Date'][1])"/>
          <xsl:text>","a":</xsl:text>
          <xsl:value-of select="normalize-space(*[local-name()='Actual']/*[local-name()='MeasureValue'][1] | *[local-name()='MeasureValue'][1])"/>
          <xsl:text>,"g":</xsl:text>
          <xsl:value-of select="normalize-space(*[local-name()='Target']/*[local-name()='MeasureValue'][1])"/>
          <xsl:text>}</xsl:text>
        </xsl:for-each>
        <xsl:text>]</xsl:text>
      </xsl:variable>

      <xsl:if test="(count(*[local-name()='ActualResults']/*[local-name()='Result']) + count(*[local-name()='Results']/*[local-name()='Result'])) &gt; 0">
        <div class="canvasWrap" role="img" aria-label="Trend line chart">
          <canvas height="260">
            <xsl:attribute name="data-series"><xsl:value-of select="$seriesJSON"/></xsl:attribute>
          </canvas>
          <div class="note mini">If charts don't appear, you're offline or Chart.js is blocked. Tables and progress bars remain as fallbacks.</div>
        </div>
      </xsl:if>
    </div>
  </xsl:template>
</xsl:stylesheet>
