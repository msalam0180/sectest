import parse from 'html-react-parser';

import globalData from '../../00-config/storybook.global-data.yml';
import twigTemplate from './button.twig';
import data from './button.yml';

const settings = {
  title: 'Components/Button',
};

const Default = args => (
  parse(twigTemplate({
    ...args,
  }))
);
Default.args = { ...globalData, ...data };

const Secondary = args => (
  parse(twigTemplate({
    ...args,
    modifier_classes: 'c-button--secondary',
  }))
);
Secondary.args = { ...globalData, ...data };

const Outline = args => (
  parse(twigTemplate({
    ...args,
    modifier_classes: 'c-button--outline',
  }))
);
Outline.args = { ...globalData, ...data };

const Danger = args => (
  parse(twigTemplate({
    ...args,
    modifier_classes: 'c-button--danger',
  }))
);
Danger.args = { ...globalData, ...data };

const Small = args => (
  parse(twigTemplate({
    ...args,
    modifier_classes: 'c-button--small',
  }))
);
Small.args = { ...globalData, ...data };

const Large = args => (
  parse(twigTemplate({
    ...args,
    modifier_classes: 'c-button--large',
  }))
);
Large.args = { ...globalData, ...data };

export default settings;
export { Default, Secondary, Outline, Danger, Small, Large };
